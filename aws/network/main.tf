terraform {
  required_version = ">= 1.0.0"
}

resource "aws_vpc" "default" {
  cidr_block           = format("%s.0.0/16", var.vpc_sub)
  enable_dns_hostnames = true
  tags = {
    Name        = "${var.name}-vpc"
    Description = "VPC for ${var.name}"
  }
}

/* Public Subnet */
resource "aws_subnet" "public" {
  count  = length(var.az_zones)
  vpc_id = aws_vpc.default.id

  cidr_block        = cidrsubnet(format("%s.0.0/21", var.vpc_sub), ceil(log(length(var.az_zones), 2)), count.index)
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
  count  = length(var.az_zones)
  vpc_id = aws_vpc.default.id

  cidr_block        = cidrsubnet(format("%s.100.0/20", var.vpc_sub), ceil(log(length(var.az_zones), 2)), count.index)
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
/* route tables */
resource "aws_route_table" "private" {
  count = !var.remove_all_private_route_tables_v1 ? length(var.az_zones) : 0

  vpc_id = aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.default.*.id, count.index)
  }

  dynamic "route" {
    for_each = concat(
      var.extra_private_routes,
      try(var.extra_private_routes_per_az[var.az_zones[count.index]], [])
    )

    content {
      cidr_block                = route.value["cidr_block"]
      vpc_peering_connection_id = route.value["vpc_peering_connection_id"]
      network_interface_id      = route.value["network_interface_id"]
    }
  }

  dynamic "route" {
    for_each = concat(
      var.extra_tgw_routes,
      try(var.extra_tgw_routes_per_az[var.az_zones[count.index]], [])
    )

    content {
      cidr_block         = route.value["cidr_block"]
      transit_gateway_id = route.value["transit_gateway_id"]
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
    for_each = var.extra_public_routes

    content {
      cidr_block                = route.value["cidr_block"]
      vpc_peering_connection_id = route.value["vpc_peering_connection_id"]
      network_interface_id      = route.value["network_interface_id"]
    }
  }

  dynamic "route" {
    for_each = concat(
      var.extra_tgw_routes,
      try(var.extra_tgw_routes_per_az[var.az_zones[count.index]], [])
    )

    content {
      cidr_block         = route.value["cidr_block"]
      transit_gateway_id = route.value["transit_gateway_id"]
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
