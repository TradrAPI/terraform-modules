output "bucket_name" {
  description = "Name of the bucket to store the plugins"

  value = (
    var.create_bucket
    ? module.mskconnect_custom_plugins.bucket_name
    : var.bucket_name
  )
}
