data "aws_ec2_transit_gateway" "this" {
  count = local.tgw_enabled ? 1 : 0

  filter {
    name   = "options.amazon-side-asn"
    values = [var.amazon_side_asn]
  }
}