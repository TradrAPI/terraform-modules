locals {
  const = {
    kms_deletion_window_in_days = 30
  }

  names = {
    fqn        = var.name
    kms_user   = "${var.name}-kms"
    kms_policy = replace(title("${var.name} kms"), "/\\s|-/", "")
  }
}
