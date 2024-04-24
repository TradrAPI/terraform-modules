data "aws_ec2_transit_gateway" "this" {
  count = var.enable_tgw_attachment ? 1 : 0

  filter {
    name   = "options.amazon-side-asn"
    values = [var.amazon_side_asn]
  }
}