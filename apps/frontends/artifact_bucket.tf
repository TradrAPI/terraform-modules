module "artifact_bucket" {
  source = "../../aws/s3"

  count = var.create_artifact_bucket ? 1 : 0

  force_destroy = var.bucket_force_destroy
  bucket_name   = "${var.environment}-frontend-artifacts-all"

  lifetime_days       = -1
  block_public_access = true
}
