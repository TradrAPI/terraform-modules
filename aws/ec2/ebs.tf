resource "aws_ebs_volume" "this" {
  count = var.ebs != null ? 1 : 0

  size              = var.ebs.size
  tags              = var.ebs.tags
  availability_zone = var.ebs.az
  type              = var.ebs.type
}

resource "aws_volume_attachment" "this" {
  count = var.ebs != null ? 1 : 0

  volume_id   = aws_ebs_volume.this[0].id
  instance_id = aws_instance.this.id

  device_name = var.ebs.device_name

  stop_instance_before_detaching = true
}
