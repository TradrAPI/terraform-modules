provider "aws" {
  region = "eu-west-2"
}

module "network" {
  source = "../.."

  az_zones = slice(data.aws_availability_zones.current.names, 0, 3)
  region   = "eu-west-2"

  vpc_cidr              = "10.111.0.0/21"
  public_subnets_cidrs  = ["10.111.0.0/24", "10.111.2.0/24", "10.111.4.0/24"]
  private_subnets_cidrs = ["10.111.1.0/24", "10.111.3.0/24", "10.111.5.0/24"]
  tgw_subnets_cidrs     = ["10.111.7.0/28", "10.111.7.16/28", "10.111.7.32/28"]

  name           = "test"
  deployment_env = "test"

  tgw_cidrs       = ["10.0.0.0/8"]
  amazon_side_asn = 4200001100

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
    "${try(route.gateway_id, route.vpc_peering_connection_id)}/${route.cidr_block}"
  ]
}

output "public_routes_v2" {
  value = [
    for route in module.network.public_routes_v2 :
    "${try(route.gateway_id, route.vpc_peering_connection_id)}/${route.destination_cidr_block}"
  ]
}


output "private_routes" {
  value = [
    for index, route in flatten(module.network.private_route_tables.*.route) :
    "${try(route.nat_gateway_id, route.vpc_peering_connection_id)}/${route.cidr_block}"
  ]
}

output "private_routes_v2" {
  value = [
    for route in module.network.private_routes_v2 :
    "${try(route.nat_gateway_id, route.vpc_peering_connection_id)}/${route.destination_cidr_block}"
  ]
}
