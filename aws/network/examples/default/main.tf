provider "aws" {
  region = "us-west-2"
}

module "network" {
  source = "../.."

  az_zones = data.aws_availability_zones.current.names
  region   = "us-west-2"
  vpc_sub  = "10.66"

  name           = "test-vpc"
  deployment_env = "test-vpc"

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
