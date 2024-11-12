resource "aws_ebs_volume" "this" {
  count = var.ebs != null ? 1 : 0

  size              = var.ebs.size
  availability_zone = var.ebs.az != null ? var.ebs.az : var.availability_zone
  type              = var.ebs.type
  iops              = var.ebs.iops

  tags = {
    Name = var.ebs.tagName != null ? var.ebs.tagName : "${var.name}-ebs${var.ebs.size}g"
  }
}

resource "aws_volume_attachment" "this" {
  count = var.ebs != null ? 1 : 0

  volume_id   = aws_ebs_volume.this[0].id
  instance_id = aws_instance.this.id

  device_name = var.ebs.device_name

  stop_instance_before_detaching = true
}
