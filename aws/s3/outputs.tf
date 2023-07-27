output "bucket_id" {
  value       = aws_s3_bucket.this.id
  description = "Bucket Name (aka ID)"
}

output "bucket" {
  value = aws_s3_bucket.this
}
