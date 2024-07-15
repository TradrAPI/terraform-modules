resource "aws_route_table" "private_v2" {
  count = var.create_route_table_v2 ? length(var.az_zones) : 0

  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.name}-Private-${var.az_zones[count.index]}-routetable-v2"
    Description = "Route table Target to Nat Gateway for ${var.name}"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }

  depends_on = [aws_nat_gateway.default]
}

resource "aws_route" "private_nat_v2" {
  count = var.create_route_table_v2 ? length(var.az_zones) : 0

  route_table_id         = aws_route_table.private_v2[count.index].id
  nat_gateway_id         = aws_nat_gateway.default[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_v2" {
  for_each = var.create_route_table_v2 ? local.private_routes_v2 : {}

  route_table_id            = aws_route_table.private_v2[index(var.az_zones, each.value.az)].id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = each.value.vpc_peering_connection_id
  transit_gateway_id        = try(each.value.transit_gateway_id, null)
}


resource "aws_route_table" "public_v2" {
  count = var.create_route_table_v2 ? length(var.az_zones) : 0

  vpc_id = aws_vpc.default.id

  tags = {
    Name        = "${var.name}-Public-${var.az_zones[count.index]}-routetable-v2"
    Description = "Route table Target to Internet Gateway for ${var.name}"
    Created-By  = "DevOps-Terraform"
    Environment = var.deployment_env
  }

  depends_on = [aws_internet_gateway.default]
}

resource "aws_route" "public_gateway_v2" {
  count = var.create_route_table_v2 ? length(var.az_zones) : 0

  route_table_id         = aws_route_table.public_v2[count.index].id
  gateway_id             = aws_internet_gateway.default.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "public_v2" {
  for_each = var.create_route_table_v2 ? local.public_routes_v2 : {}

  route_table_id            = aws_route_table.public_v2[index(var.az_zones, each.value.az)].id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = try(each.value.vpc_peering_connection_id, null)
  transit_gateway_id        = try(each.value.transit_gateway_id, null)

}

locals {
  private_routes_v2 = merge({
    for index, az_route in setproduct(var.az_zones, distinct(concat(var.extra_private_routes, local.extra_tgw_routes))) :
    "${az_route[0]}/${az_route[1].cidr_block}" => merge(az_route[1], { az = az_route[0] })
  })

  _extra_public_routes = distinct(concat(
    var.extra_public_routes,
    var.enable_tgw_routes_in_public_subnets ? local.extra_tgw_routes : []
  ))

  public_routes_v2 = {
    for index, az_route in setproduct(var.az_zones, local._extra_public_routes) :
    "${az_route[0]}/${az_route[1].cidr_block}" => merge(az_route[1], { az = az_route[0] })
  }
}
