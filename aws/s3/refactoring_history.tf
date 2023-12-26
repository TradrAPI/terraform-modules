moved {
  from = aws_s3_bucket_public_access_block.private_bucket_with_expiration_access
  to   = aws_s3_bucket_public_access_block.private_bucket_with_expiration_access[0]
}

moved {
  from = aws_s3_bucket.private_bucket_with_expiration
  to   = aws_s3_bucket.this
}

moved {
  from = aws_s3_bucket_public_access_block.private_bucket_with_expiration_access
  to   = aws_s3_bucket_public_access_block.this
}

moved {
  from = aws_s3_bucket_acl.this
  to   = aws_s3_bucket_acl.this[0]
}
