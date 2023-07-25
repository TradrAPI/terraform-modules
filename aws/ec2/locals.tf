locals {
  ami_id = (
    var.ami_filter != null
    ? data.aws_ami.this[0].id
    : var.ami_id
  )

  # This will prevent rate limit errors when providing
  # to the module big cidrs lists
  http_cidrs_groups = chunklist(var.http_trusted_cidrs, 20)

  user_data = (
    var.os_type == "linux"
    ? local.linux_user_data
    : local.win_user_data
  )

  linux_user_data = (
    var.user_data != null
    ? var.user_data
    : join("\n", [
      "#cloud-config",
      yamlencode(var.user_data_obj)
    ])
  )

  win_user_data = base64encode(join("\n", [
    "<powershell>",
    templatefile("${path.module}/templates/windows_user_data.ps1", {
      admin_user = var.win_admin_user
    }),
    (var.user_data == null ? "" : var.user_data),
    "</powershell>",
  ]))

  https_port      = 443
  tcp_protocol    = "tcp"
  ingress_sg_rule = "ingress"
  egress_sg_rule  = "egress"
  any_port        = 0
  any_protocol    = "-1"
  any_ip          = ["0.0.0.0/0"]
}
