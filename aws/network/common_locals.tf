locals {
  tgw_enabled = length(var.tgw_cidrs) > 0

  extra_tgw_routes = [
    for route in var.tgw_cidrs :
    {
      cidr_block                = route
      transit_gateway_id        = data.aws_ec2_transit_gateway.this[0].id
      vpc_peering_connection_id = null
    }
  ]
}
