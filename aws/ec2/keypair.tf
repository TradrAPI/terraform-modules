resource "aws_key_pair" "this" {
  count = var.key_pair != null ? 1 : 0

  key_name   = var.key_pair.name
  public_key = var.key_pair.public_key
}
