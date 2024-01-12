resource "aws_instance" "this" {
  ami = data.aws_ami.this.id

  vpc_security_group_ids = concat(
    var.security_group_ids,
    aws_security_group.http.*.id,
    [aws_security_group.this.id]
  )

  user_data = local.user_data

  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  private_ip                  = var.private_ip
  availability_zone           = var.az
  associate_public_ip_address = var.associate_public_ip

  tags = merge(var.tags, {
    Name           = var.name
    AnsibleGroup   = var.ansible_group
    AnsibleManaged = "yes"
  })

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = local.const.gp2_volume_type
  }

  lifecycle {
    ignore_changes = [ami, user_data]
  }
}
