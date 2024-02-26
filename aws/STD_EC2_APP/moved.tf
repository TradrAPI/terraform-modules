moved {
  from = aws_ebs_volume.this
  to   = aws_ebs_volume.this[0]
}

moved {
  from = aws_volume_attachment.this
  to   = aws_volume_attachment.this[0]
}

moved {
  from = module.this.aws_instance.this
  to   = aws_instance.this
}

moved {
  from = module.this.data.aws_ami.this[0]
  to   = data.aws_ami.this
}

moved {
  from = module.this.aws_security_group.this
  to   = aws_security_group.this
}

moved {
  from = module.this.aws_security_group.http
  to   = aws_security_group.http
}

moved {
  from = module.this.aws_security_group_rule.ssh_ingress
  to   = aws_security_group_rule.ssh_ingress
}

moved {
  from = module.this.aws_security_group_rule.http_ingress
  to   = aws_security_group_rule.http_ingress
}

moved {
  from = module.this.aws_security_group_rule.https_ingress
  to   = aws_security_group_rule.https_ingress
}

moved {
  from = module.this.aws_security_group_rule.egress_all_tcp
  to   = aws_security_group_rule.egress_all_tcp
}

moved {
  from = module.this.aws_eip.this
  to   = aws_eip.this
}
