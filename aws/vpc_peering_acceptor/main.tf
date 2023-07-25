resource "aws_vpc_peering_connection_options" "this" {
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.this.id

  accepter {
    allow_remote_vpc_dns_resolution = var.allow_remote_vpc_dns_resolution
  }
}

resource "aws_vpc_peering_connection_accepter" "this" {
  vpc_peering_connection_id = var.peering_conn_id
  auto_accept               = true

  tags = {
    Name = var.name
  }
}

resource "aws_security_group_rule" "this" {
  for_each = local.sg_rules

  security_group_id = var.sg_id

  cidr_blocks = try(each.value.cidr_blocks, [var.requester_cidr])

  type        = each.value.type
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  description = each.value.description
}

locals {
  sg_rules = {
    for rule in var.sg_rules :
    join("_", [
      rule.type,
      rule.protocol == "-1" ? "all" : rule.protocol,
      rule.from_port == 0 ? "any_port" : rule.from_port,
      "to",
      rule.to_port == 0 ? "any_port" : rule.to_port,
    ]) => rule
  }
}
