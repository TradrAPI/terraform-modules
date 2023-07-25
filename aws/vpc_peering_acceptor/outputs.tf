output "routes_back_to_requester_vpc" {
  value = [{
    cidr_block                = var.requester_cidr
    vpc_peering_connection_id = var.peering_conn_id
  }]

  description = "Pass this as `extra_public_routes` and `extra_private_routes` input vars on the NETWORK module usage on the requester VPC code."
}
