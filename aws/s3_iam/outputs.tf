output "group" {
  value = {
    name = var.group
    arn  = module.iam_structures.groups[var.group]
  }
}

output "role" {
  value = try({
    name = var.role
    arn  = module.iam_structures.roles[var.role]
  }, null)
}

output "policy" {
  value = {
    name = var.policy
  }
}

output "user" {
  value = {
    name = var.user
    access_keys = {
      id     = module.users.access_keys[var.user].id
      secret = module.users.access_keys[var.user].secret
    }
  }
}
