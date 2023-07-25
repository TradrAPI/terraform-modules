output "mongodb_uri" {
    value = local.mongodb_full_uri
    sensitive = true
}

output "mongodb_uri_shards" {
    value = local.mongodb_full_uri_shards
    sensitive = true
}

output "mongodb_uri_encrypted" {
    value = local.mongodb_full_uri_encrypted
}

output "mongodb_username" {
    value = mongodbatlas_database_user.user.username
}

output "mongodb_password" {
    value = mongodbatlas_database_user.user.password
    sensitive = true
}

output "this" {
    value = mongodbatlas_database_user.user
}

output "iv" {
    value = local.iv_output
    sensitive = true
}

