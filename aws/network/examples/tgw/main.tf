variable "amazon_side_asn" {
  type = string
}

provider "aws" {
  region = "eu-west-2"
}

module "network" {
  source = "../.."

  az_zones = data.aws_availability_zones.current.names
  region   = "eu-west-2"
  vpc_sub  = "10.66"

  name           = "test-vpc"
  deployment_env = "test-vpc"

  amazon_side_asn                     = var.amazon_side_asn
  enable_tgw_routes_in_public_subnets = true

  tgw_cidrs = [
    "10.0.0.0/8", # any non local traffic goes through the TGW
  ]

  extra_private_routes = []
  extra_public_routes  = []
}

data "aws_availability_zones" "current" {
  state = "available"
}

data "aws_caller_identity" "current" {}

output "public_routes" {
  value = [
    for index, route in flatten(module.network.public_route_tables.*.route) :
    "${coalesce(route.gateway_id, route.vpc_peering_connection_id, route.transit_gateway_id)}/${route.cidr_block}"
  ]
}

output "private_routes" {
  value = [
    for index, route in flatten(module.network.private_route_tables.*.route) :
    "${coalesce(route.nat_gateway_id, route.vpc_peering_connection_id, route.transit_gateway_id)}/${route.cidr_block}"
  ]
}
