locals {
  const = {
    https_port            = 443
    http_port             = 80
    tcp_protocol          = "tcp"
    ingress_sg_rule       = "ingress"
    egress_sg_rule        = "egress"
    any_port              = 0
    any_protocol          = "-1"
    any_ip                = ["0.0.0.0/0"]
    gp2_volume_type       = "gp2"
  }

  user_data = join("\n", [
    "#cloud-config",
    yamlencode(local._user_data_obj)
  ])

  _user_data_obj = merge(
    var.user_data_obj,
    local.data_volume_user_data,
    {
      runcmd = local.runcmd

      package_update = true

      packages = [
        "ca-certificates",
        "curl",
        "gnupg",
        "lsb-release",
      ]

      timezone = "Europe/Berlin"

      swap = {
        filename = "/swap.img"
        size     = var.swap_size * 1024 * 1024 * 1024
      }

      users = [{
        name   = "devops-admin"
        groups = "sudo"
        shell  = "/bin/bash"
        sudo   = "ALL=(ALL) NOPASSWD:ALL"

        ssh_authorized_keys = [
          var.authorized_key
        ]
      }]

      write_files = concat(try(var.user_data_obj.write_files, []), [{
        encoding    = "gz+b64"
        owner       = "root:root"
        path        = "/etc/ssh/sshd_config"
        permissions = "0644"

        content = base64gzip(templatefile("${path.module}/templates/sshd_config", {
          ssh_port = var.ssh_port
        }))
      }])
    }
  )

  data_volume_user_data = (
    var.data_volume_size == null
    ? null
    : {
      fs_setup = [{
        device     = local._data_device_by_id
        partition  = "auto"
        label      = "instance-data"
        filesystem = "ext4"
        overwrite  = false
      }]

      mounts = [
        ["LABEL=instance-data", "/mnt/instance-data", "ext4", "nofail,defaults", "0", "0"]
      ]

      bootcmd = [
        "cloud-init-per once wait-for-ebs-attachment sleep 30",
      ]
    }
  )

  _data_device_by_id = try(
    "/dev/disk/by-id/nvme-Amazon_Elastic_Block_Store_${replace(aws_ebs_volume.this[0].id, "-", "")}",
    ""
  )

  runcmd = (
    var.certbot != null
    ? local._runcmd_with_cert
    : local._raw_runcmd
  )

  _raw_runcmd = try(var.user_data_obj.runcmd, [])

  _runcmd_with_cert = concat([
    "mkdir -p /mnt/instance-data/letsencrypt",
    "ln -sf /mnt/instance-data/letsencrypt /etc/letsencrypt",
    "mkdir -p /root/.secrets/certbot",
    "echo 'dns_cloudflare_api_token = ${local._certbot.cloudflare_api_token}' > /root/.secrets/certbot/cloudflare.ini",
    "chmod 0600 /root/.secrets/certbot/cloudflare.ini",
    "snap install core",
    "snap refresh core",
    "snap install --classic certbot",
    "snap set certbot trust-plugin-with-root=ok",
    "snap install certbot-dns-cloudflare",
    "certbot certonly ${local._certbot.test ? "--test-cert" : ""} --dns-cloudflare --dns-cloudflare-credentials /root/.secrets/certbot/cloudflare.ini --agree-tos -nm ${local._certbot.notification_email} -d ${local._certbot.fqdn}",
  ], local._raw_runcmd)

  _certbot = {
    fqdn                 = try(var.certbot.fqdn, "")
    cloudflare_api_token = try(var.certbot.cloudflare_api_token, "")
    notification_email   = try(var.certbot.notification_email, "")
    test                 = try(var.certbot.test, true)
  }

  # This will prevent rate limit errors when providing
  # to the module big cidrs lists
  http_cidrs_groups = chunklist(var.http_trusted_cidrs, 20)
}
