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

/* Subnets Assciation for Public and Private */
resource "aws_route_table_association" "private" {
  count = length(var.az_zones)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private[count.index].id

  depends_on = [
    aws_subnet.private,
    aws_route_table.private,
  ]
}

resource "aws_route_table_association" "public" {
  count = length(var.az_zones)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public[count.index].id

  depends_on = [
    aws_subnet.public,
    aws_route_table.public,
  ]
}
