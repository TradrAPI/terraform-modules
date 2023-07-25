module "gitlab" {
  source = "../ec2"

  attach_eip                  = true
  allow_https                 = true
  associate_public_ip_address = true

  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  availability_zone  = var.az_zone
  security_group_ids = var.security_group_ids
  private_ip         = var.private_ip

  iam_instance_profile = aws_iam_instance_profile.bucket_iam.name

  resources_prefix   = var.resources_prefix
  ssh_trusted_cidrs  = var.instance_ssh_trusted_cidrs
  ssh_port           = var.instance_ssh_port
  root_volume_size   = var.root_volume_size
  http_trusted_cidrs = var.http_trusted_cidrs
  name               = var.name
  type               = var.type

  tags = merge(var.tags, {
    Name = var.name
  })

  ami_filter = {
    owner = local.canonical_ami_owner_id
    name  = local.ubuntu_image_name_pattern
  }

  ebs = {
    device_name = local.ebs_device_name
    type        = local.gp2_ebs_type

    az   = var.az_zone
    size = var.data_volume_size

    tags = merge(var.data_volume_tags, {
      Name = var.name
    })
  }

  user_data = templatefile("${path.module}/templates/user_data.yml", {
    ebs_device_name            = local.ebs_device_name
    admin_authorized_key       = var.admin_authorized_key
    swap_size                  = var.swap_size
    cloudflare_certbot_token   = var.cloudflare_certbot_token
    use_test_cert              = var.use_test_cert
    certbot_notification_email = var.certbot_notification_email
    gitlab_fqdn                = var.gitlab_fqdn

    sshd_config = base64gzip(templatefile("${path.module}/templates/sshd_config", {
      ssh_port = var.instance_ssh_port
    }))
  })
}

resource "aws_security_group_rule" "gitlab_ssh_port_ingress" {
  security_group_id = module.gitlab.sg.id

  type        = "ingress"
  description = "Allows GitLab ssh traffic"

  cidr_blocks = var.gitlab_ssh_trusted_cidrs
  protocol    = local.tcp_protocol
  from_port   = local.ssh_gitlab_port
  to_port     = local.ssh_gitlab_port
}

locals {
  ebs_device_name           = "/dev/xvdf"
  ssh_gitlab_port           = 22
  tcp_protocol              = "tcp"
  gp2_ebs_type              = "gp2"
  canonical_ami_owner_id    = "099720109477"
  ubuntu_image_name_pattern = "ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"
}
