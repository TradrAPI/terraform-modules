resource "aws_eip" "this" {
  count = var.attach_eip ? 1 : 0

  instance = aws_instance.this.id
}
