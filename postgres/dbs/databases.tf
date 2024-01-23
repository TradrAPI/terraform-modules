resource "postgresql_database" "databases" {
  for_each = toset(var.databases)

  name  = each.value
  owner = var.owner
}
