output "users" {
  value = {
    for name, role in var.roles:
    name => random_password.all[name].result
    if role.login
  }
}