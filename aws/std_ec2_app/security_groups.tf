resource "aws_security_group" "this" {
  name        = "${var.resources_prefix}-ec2-sg"
  description = "${var.name} security group"

  vpc_id = var.vpc_id
}

resource "aws_security_group" "http" {
  count = length(local.http_cidrs_groups)

  name        = "${var.resources_prefix}-ec2-http${count.index}-sg"
  description = "Specifies http+https access to the instance."

  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ssh_ingress" {
  count = length(var.ssh_trusted_cidrs) > 0 ? 1 : 0

  security_group_id = aws_security_group.this.id

  cidr_blocks = var.ssh_trusted_cidrs

  type      = local.const.ingress_sg_rule
  protocol  = local.const.tcp_protocol
  from_port = var.ssh_port
  to_port   = var.ssh_port

  description = "Allows SSH traffic"
}

resource "aws_security_group_rule" "http_ingress" {
  count = length(local.http_cidrs_groups)

  security_group_id = aws_security_group.http[count.index].id

  from_port = local.const.http_port
  to_port   = local.const.http_port

  cidr_blocks = local.http_cidrs_groups[count.index]
  type        = local.const.ingress_sg_rule
  protocol    = local.const.tcp_protocol

  description = "Allows HTTP traffic"
}

resource "aws_security_group_rule" "https_ingress" {
  count = length(local.http_cidrs_groups)

  security_group_id = aws_security_group.http[count.index].id

  from_port = local.const.https_port
  to_port   = local.const.https_port

  cidr_blocks = local.http_cidrs_groups[count.index]
  type        = local.const.ingress_sg_rule
  protocol    = local.const.tcp_protocol

  description = "Allows HTTPS traffic"
}

resource "aws_security_group_rule" "egress_all_tcp" {
  security_group_id = aws_security_group.this.id

  type        = local.const.egress_sg_rule
  from_port   = local.const.any_port
  to_port     = local.const.any_port
  protocol    = local.const.any_protocol
  cidr_blocks = local.const.any_ip

  description = "Allows outbound to everywhere"
}
