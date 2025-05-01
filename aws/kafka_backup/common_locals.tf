locals {
  bucket_name = (
    var.create_backup_bucket
    ? module.backup_bucket[0].bucket.id
    : var.backup_bucket_name
  )
}
