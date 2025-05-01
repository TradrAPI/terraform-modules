module "backup_bucket" {
  source = "../s3"

  count = var.create_backup_bucket ? 1 : 0

  bucket_name = "${var.resources_prefix}-msk-backup"

  block_public_access = true
  create_bucket_acl   = false

  lifetime_days = var.bucket_lifetime_days
}

resource "aws_s3_bucket_server_side_encryption_configuration" "backup_bucket" {
  count = var.create_backup_bucket ? 1 : 0

  bucket = module.backup_bucket[0].bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
