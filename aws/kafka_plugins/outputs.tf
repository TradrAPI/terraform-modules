output "bucket_name" {
  description = "Name of the bucket to store the plugins"

  value = (
    var.create_bucket
    ? module.plugins_bucket.bucket_name
    : var.bucket_name
  )
}

output "plugins" {
  description = "A map of plugins names to their resource objects"

  value = aws_mskconnect_custom_plugin.plugins
}
