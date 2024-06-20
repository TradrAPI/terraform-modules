resource "aws_ebs_volume" "this" {
  count = var.data_volume_size != null ? 1 : 0

  size              = var.data_volume_size
  availability_zone = var.az
  type              = "gp2"

  tags = merge(var.data_volume_tags, {
    Name = "${var.resources_prefix}-ebs"
  })
}

resource "aws_volume_attachment" "this" {
  count = var.data_volume_size != null ? 1 : 0

  volume_id                      = aws_ebs_volume.this[0].id
  instance_id                    = aws_instance.this.id
  device_name                    = "/dev/xvdf"
  stop_instance_before_detaching = true
}
