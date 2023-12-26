resource "aws_ebs_volume" "extra" {
  for_each = var.extra_volumes

  availability_zone = var.az_zone
  tags              = each.value.tags
  size              = each.value.size
  type              = "gp2"
}

resource "aws_volume_attachment" "extra" {
  for_each = aws_ebs_volume.extra

  instance_id                    = module.gitlab.this.id
  stop_instance_before_detaching = true

  volume_id   = each.value.id
  device_name = var.extra_volumes[each.key].device_name
}

moved {
  from = aws_ebs_volume.registry
  to   = aws_ebs_volume.extra["registry"]
}

moved {
  from = aws_volume_attachment.registry
  to   = aws_volume_attachment.extra["registry"]
}
