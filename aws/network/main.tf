terraform {
  required_version = ">= 1.0.0"
}

resource "aws_vpc" "default" {
  cidr_block = (
    var.vpc_cidr == null
    ? format("%s.0.0/16", var.vpc_sub)
    : var.vpc_cidr
  )

  enable_dns_hostnames = true

  tags = {
    Name        = "${var.name}-vpc"
    Description = "VPC for ${var.name}"
  }
}

/* Public Subnet */
resource "aws_subnet" "public" {
  count = length(var.az_zones)

  vpc_id = aws_vpc.default.id

  cidr_block = (
    length(var.public_subnets_cidrs) <= 0
    ? cidrsubnet(format("%s.0.0/21", var.vpc_sub), ceil(log(length(var.az_zones), 2)), count.index)
    : var.public_subnets_cidrs[count.index]
  )

  availability_zone = var.az_zones[count.index]

  tags = merge(
    var.public_subnet_tags,
    {
      Name        = "${var.name}-Public-${var.az_zones[count.index]}-subnet"
      Description = "Public Subnet for ${var.name}"
      Created-By  = "DevOps-Terraform"
      Environment = var.deployment_env
    }
  )
}

/* Private Subnet */
resource "aws_subnet" "private" {
  count = length(var.az_zones)

  vpc_id = aws_vpc.default.id

  cidr_block = (
    length(var.private_subnets_cidrs) <= 0
    ? cidrsubnet(format("%s.100.0/20", var.vpc_sub), ceil(log(length(var.az_zones), 2)), count.index)
    : var.private_subnets_cidrs[count.index]
  )

  availability_zone = var.az_zones[count.index]

  tags = merge(
    var.private_subnet_tags,
    {
      Name        = "${var.name}-Private-${var.az_zones[count.index]}-subnet"
      Description = "Private Subnet for ${var.name}"
      Created-By  = "DevOps-Terraform"
      Environment = var.deployment_env
    }
  )
}

/* Transit Gateway Subnet */
resource "aws_subnet" "tgw" {
  count = length(var.tgw_cidrs) > 0 ? length(var.az_zones) : 0

  vpc_id = aws_vpc.default.id

  cidr_block = (
    length(var.tgw_subnets_cidrs) <= 0
    ? cidrsubnet(format("%s.255.0/26", var.vpc_sub), ceil(log(length(var.az_zones), 2)), count.index)
    : var.tgw_subnets_cidrs[count.index]
  )

  availability_zone = var.az_zones[count.index]

  tags = merge(
    var.tgw_subnet_tags,
    {
      Name        = "${var.name}-TGW-${var.az_zones[count.index]}-subnet"
      Description = "TGW Subnet for ${var.name}"
      Created-By  = "DevOps-Terraform"
      Environment = var.deployment_env
    }
  )
}

/* Gateways Nat and Internet */
resource "aws_eip" "nat" {
  count  = length(var.az_zones)
  domain = "vpc"
  tags = {
    Name        = "${var.name}-${var.az_zones[count.index]}-eip"
    Description = "Internet Gateway for NAT Gateway"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }
}

resource "aws_nat_gateway" "default" {
  count         = length(var.az_zones)
  allocation_id = element(aws_eip.nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  depends_on    = [aws_subnet.public]

  tags = {
    Name        = "${var.name}-${var.az_zones[count.index]}-natgw"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name        = "${var.name}-internetgw"
    Description = "Internet Gateway for Public Subnets for ${var.name}"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }
}

/* TGW attachments */
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = local.tgw_enabled ? 1 : 0

  subnet_ids = [
    for subnet in aws_subnet.tgw : subnet.id
  ]

  transit_gateway_id = data.aws_ec2_transit_gateway.this[0].id
  vpc_id             = aws_vpc.default.id

  tags = {
    Name = "${aws_vpc.default.tags.Name}-vpc"
  }
}


/* route tables */
resource "aws_route_table" "private" {
  count = !var.remove_all_private_route_tables_v1 ? length(var.az_zones) : 0

  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.default.*.id, count.index)
  }

  dynamic "route" {
    for_each = distinct(concat(
      var.extra_private_routes,
      local.extra_tgw_routes,
      try(var.extra_private_routes_per_az[var.az_zones[count.index]], []),
    ))

    content {
      cidr_block                = route.value["cidr_block"]
      vpc_peering_connection_id = try(route.value["vpc_peering_connection_id"], null)
      network_interface_id      = try(route.value["network_interface_id"], null)
      transit_gateway_id        = try(route.value["transit_gateway_id"], null)
    }
  }


  tags = {
    Name        = "${var.name}-Private-${var.az_zones[count.index]}-routetable"
    Description = "Route table Target to Nat Gateway for ${var.name}"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }

  depends_on = [aws_nat_gateway.default]
}

resource "aws_route_table" "public" {
  count  = !var.remove_all_public_route_tables_v1 ? length(var.az_zones) : 0
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  dynamic "route" {
    for_each = distinct(concat(
      var.extra_public_routes,
      var.enable_tgw_routes_in_public_subnets ? local.extra_tgw_routes : [],
    ))

    content {
      cidr_block                = route.value["cidr_block"]
      vpc_peering_connection_id = try(route.value["vpc_peering_connection_id"], null)
      network_interface_id      = try(route.value["network_interface_id"], null)
      transit_gateway_id        = try(route.value["transit_gateway_id"], null)
    }
  }

  tags = {
    Name        = "${var.name}-Public-${var.az_zones[count.index]}-routetable"
    Description = "Route table Target to Internet Gateway for ${var.name}"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }
  depends_on = [aws_internet_gateway.default]
}

/* Subnets Assciation for Public and Private */
resource "aws_route_table_association" "private" {
  count = length(var.az_zones)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = (
    count.index < var.associate_private_route_table_v2
    ? aws_route_table.private_v2[count.index].id
    : aws_route_table.private[count.index].id
  )

  depends_on = [
    aws_subnet.private,
    aws_route_table.private,
  ]
}

resource "aws_route_table_association" "public" {
  count = length(var.az_zones)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = (
    count.index < var.associate_public_route_table_v2
    ? aws_route_table.public_v2[count.index].id
    : aws_route_table.public[count.index].id
  )

  depends_on = [
    aws_subnet.public,
    aws_route_table.public,
  ]
}
