resource "aws_vpc_peering_connection" "this" {
  for_each = var.peer_vpcs

  tags          = each.value.tags
  peer_owner_id = each.value.peer_owner_id
  peer_vpc_id   = each.value.peer_vpc_id
  peer_region   = each.value.peer_region

  vpc_id = var.vpc_id
}

resource "aws_vpc_peering_connection_options" "this" {
  for_each = {
    for peer, attr in var.peer_vpcs :
    peer => attr
    if attr.allow_remote_vpc_dns_resolution
  }

  vpc_peering_connection_id = aws_vpc_peering_connection.this[each.key].id

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  depends_on = [
    aws_vpc_peering_connection.this
  ]
}
