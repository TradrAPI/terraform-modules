resource "aws_instance" "this" {
  depends_on = [
    aws_ebs_volume.this
  ]

  ami      = local.ami_id
  key_name = try(aws_key_pair.this[0].key_name, null)

  iam_instance_profile = var.iam_instance_profile

  vpc_security_group_ids = concat(
    var.security_group_ids,
    aws_security_group.http.*.id,
    [aws_security_group.this.id]
  )

  user_data = local.user_data

  get_password_data           = var.get_password_data
  instance_type               = var.type
  associate_public_ip_address = var.associate_public_ip_address
  subnet_id                   = var.subnet_id
  private_ip                  = var.private_ip
  availability_zone           = var.availability_zone
  disable_api_termination     = var.disable_api_termination

  tags = merge(var.tags, {
    Name = var.name
  })

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    iops        = var.iops
  }

  lifecycle {
    ignore_changes = [ami, user_data]
  }
}
