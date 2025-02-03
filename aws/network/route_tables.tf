resource "aws_route_table" "private" {
  count = length(var.az_zones)

  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.name}-Private-${var.az_zones[count.index]}"
    Description = "Route table Target to Nat Gateway for ${var.name}"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }

  depends_on = [aws_nat_gateway.default]
}

moved {
  from = aws_route_table.private_v2
  to   = aws_route_table.private
}

resource "aws_route" "private_nat" {
  count = length(var.az_zones)

  route_table_id         = aws_route_table.private[count.index].id
  nat_gateway_id         = aws_nat_gateway.default[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}

moved {
  from = aws_route.private_nat_v2
  to   = aws_route.private_nat
}

resource "aws_route" "private" {
  for_each = local.private_routes

  route_table_id            = aws_route_table.private[index(var.az_zones, each.value.az)].id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
}

moved {
  from = aws_route.private_v2
  to   = aws_route.private
}

resource "aws_route_table" "public" {
  count = length(var.az_zones)

  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.name}-Public-${var.az_zones[count.index]}"
    Description = "Route table Target to Internet Gateway for ${var.name}"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }

  depends_on = [aws_internet_gateway.default]
}

moved {
  from = aws_route_table.public_v2
  to   = aws_route_table.public
}

resource "aws_route" "public_gateway" {
  count = length(var.az_zones)

  route_table_id         = aws_route_table.public[count.index].id
  gateway_id             = aws_internet_gateway.default.id
  destination_cidr_block = "0.0.0.0/0"
}

moved {
  from = aws_route.public_gateway_v2
  to   = aws_route.public_gateway
}

resource "aws_route" "public" {
  for_each = local.public_routes

  route_table_id            = aws_route_table.public[index(var.az_zones, each.value.az)].id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
}

moved {
  from = aws_route.public_v2
  to   = aws_route.public
}

locals {
  private_routes = merge({
    for index, az_route in setproduct(var.az_zones, distinct(concat(var.extra_private_routes, local.extra_tgw_routes))) :
    "${az_route[0]}/${az_route[1].cidr_block}" => merge(az_route[1], { az = az_route[0] })
  })

  _extra_public_routes = distinct(concat(
    var.extra_public_routes,
    var.enable_tgw_routes_in_public_subnets ? local.extra_tgw_routes : []
  ))

  public_routes = {
    for index, az_route in setproduct(var.az_zones, local._extra_public_routes) :
    "${az_route[0]}/${az_route[1].cidr_block}" => merge(az_route[1], { az = az_route[0] })
  }
}
