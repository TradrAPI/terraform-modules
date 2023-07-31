output "bucket" {
  value = try(module.bucket[0].bucket, data.aws_s3_bucket.this[0])
}

output "artifact_bucket" {
  value = try(module.artifact_bucket[0].bucket, null)
}
