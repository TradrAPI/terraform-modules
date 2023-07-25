data "mongodbatlas_cluster" "this" {
  provider           = mongodbatlas.creds 
  count = var.create_outputs == true ? 1 : 0
  project_id = var.mongodb_projectid
  name       = var.mongodb_clusters[0]
}

resource "mongodbatlas_database_user" "user" {
  provider           = mongodbatlas.creds 
  username           = var.external_username != null ? var.external_username : lower("${var.platform}-${var.brandname}${var.name_suffix}")
  password           = var.external_password != null ? var.external_password : random_password.password[0].result
  project_id         = var.mongodb_projectid
  auth_database_name = "admin"

  dynamic "roles" {
    for_each = toset(var.mongodb_permissions)

    content {
      role_name     = roles.value.role
      database_name = roles.value.dbname
    }
  }

  dynamic "scopes" {
    for_each = toset(var.mongodb_clusters)

    content {
      name     = scopes.value
      type     = "CLUSTER"
    }
  }
}

resource "random_password" "password" {
  count   = var.external_password == null ? 1 : 0
  length  = 24
  special = false
}

locals {
  mongodb_cluster_srv_address = (var.create_outputs == true ? split("//", data.mongodbatlas_cluster.this[0].srv_address)[1] : null)
  mongodb_cluster_replicaset  = (var.create_outputs == true ? regex("replicaSet=.*$", data.mongodbatlas_cluster.this[0].mongo_uri_with_options) : null)
  mongodb_dbname = (var.create_outputs == true ? var.mongodb_permissions[0].dbname : null)
  mongodb_cluster_shards = (var.create_outputs == true ? regex("(([a-z0-9-]+-shard-[0-9]+-[0-9]+.[a-z0-9]+.mongodb.net:27017,?)+)", data.mongodbatlas_cluster.this[0].connection_strings[0].standard)[0] : null)

  mongodb_full_uri = (var.create_outputs == true ? "mongodb+srv://${mongodbatlas_database_user.user.username}:${mongodbatlas_database_user.user.password}@${local.mongodb_cluster_srv_address}/${local.mongodb_dbname}?authSource=admin&${local.mongodb_cluster_replicaset}&w=majority&readPreference=primary&appname=MongoDB%20Compass&retryWrites=true&ssl=true" : null )
  
  mongodb_full_uri_shards = (var.create_outputs == true ? "mongodb://${mongodbatlas_database_user.user.username}:${mongodbatlas_database_user.user.password}@${local.mongodb_cluster_shards}/${local.mongodb_dbname}?${local.mongodb_cluster_replicaset}&ssl=true&authSource=admin&retryWrites=true&w=majority" : null )

  mongodb_full_uri_encrypted = (var.create_outputs == true ? data.external.encrypt[0].result.uri_encrypted : null )
  iv_output = ( var.create_outputs == true ? random_password.iv[0].result : null )
}

data "external" "encrypt" {
  count   = var.create_outputs == true ? 1 : 0
  program = ["bash", "encrypt.sh"]
  working_dir = path.module
  query = {
    uri = ( var.connection_string_shards == true ? local.mongodb_full_uri_shards : local.mongodb_full_uri )
    key = var.encryption_key
    iv  = random_password.iv[0].result
  }
}

resource "random_password" "iv" {
  count            = var.create_outputs == true ? 1 : 0
  length           = 16
  special          = false
  upper            = false
}
