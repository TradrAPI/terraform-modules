locals {
  const = {
    kms_deletion_window_in_days = 30
  }

  names = {
    fqn        = "${var.prefix}${var.platform}-${var.name}"
    kms_user   = "${var.prefix}${var.platform}-${var.name}-kms"
    kms_policy = replace(title("${var.prefix}${var.platform} ${var.name} kms"), "/\\s|-/", "")
  }
}
