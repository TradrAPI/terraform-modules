output "routes_to_accepter_vpcs" {
  value = [
    for name, peer in aws_vpc_peering_connection.this : {
      cidr_block                = var.peer_vpcs[name].peer_cidr
      vpc_peering_connection_id = peer.id
    }
  ]
}

output "peer_connections" {
  value = aws_vpc_peering_connection.this
}