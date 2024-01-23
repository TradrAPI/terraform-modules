resource "postgresql_role" "all" {
  for_each = var.roles

  name     = each.key
  login    = try(each.value.login, false)
  inherit  = true
  password = each.value.login ? random_password.all[each.key].result : null
}

resource "random_password" "all" {
  for_each = { for k, v in var.roles : k => v if try(v.login, false) }

  length  = 32
  special = false
}

resource "postgresql_schema" "public" {
  for_each = toset(var.databases)

  owner    = var.owner
  database = each.value
  name     = "public"
}

resource "postgresql_grant" "pg_tables" {
  for_each = local.role_with_privileges_per_db

  database   = each.value.target_dbs
  role       = postgresql_role.all[each.value.role].name
  privileges = each.value.privileges.table

  schema      = "public"
  object_type = "table"
  objects     = [] # all

  depends_on = [postgresql_database.databases]
}

resource "postgresql_grant" "pg_schema" {
  for_each = local.role_with_privileges_per_db

  database   = each.value.target_dbs
  role       = postgresql_role.all[each.value.role].name
  privileges = each.value.privileges.schema

  schema      = "public"
  object_type = "schema"

  depends_on = [postgresql_database.databases]
}

resource "postgresql_grant" "pg_sequence" {
  for_each = local.role_with_privileges_per_db

  database   = each.value.target_dbs
  role       = postgresql_role.all[each.value.role].name
  privileges = each.value.privileges.sequence

  schema      = "public"
  object_type = "sequence"

  depends_on = [postgresql_database.databases]
}

resource "postgresql_grant_role" "human_users" {
  for_each = { for k, v in var.roles : k => v if can(v.role) }

  role       = each.key
  grant_role = each.value.role

  depends_on = [postgresql_role.all]
}

locals {
  role_with_privileges_per_db = {
    for v in local._role_with_privileges_per_db :
    "${v[0][0]}/${v[0][1].name}" => {
      target_dbs = v[0][0],
      role       = v[0][1].name,
      privileges = v[0][1].privileges
    }
  }
  _role_with_privileges_per_db = [
    for k, v in var.roles :
    setproduct(v.target_dbs, [{ name = k, privileges = v.privileges }])
    if can(v.privileges)
  ]
}
