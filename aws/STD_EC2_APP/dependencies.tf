data "aws_ami" "this" {
  most_recent = true
  owners      = [var.ami_filter.owner]

  filter {
    name   = "name"
    values = [var.ami_filter.name]
  }
}
