output "connect" {
  value = "ssh -i files/testkey devops-admin@${module.instance.this.private_ip}"
}

output "curl" {
  value = "curl ${module.instance.this.private_ip}:8080"
}

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
