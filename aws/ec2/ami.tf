data "aws_ami" "this" {
  count = var.ami_filter != null ? 1 : 0

  most_recent = true
  owners      = [var.ami_filter.owner]

  filter {
    name = "name"

    values = [
      var.ami_filter.name
    ]
  }
}
