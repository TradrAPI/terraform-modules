terraform {
  required_version = ">= 1.0.0"
}

resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = {
    Name = var.bucket_name
  }
}

# terraform import module.<name>.aws_s3_bucket_acl.this <bucket-name>,private
resource "aws_s3_bucket_acl" "this" {
  count = var.create_bucket_acl ? 1 : 0

  bucket = aws_s3_bucket.this.id

  acl = "private"
}

# terraform import module.<name>.aws_s3_bucket_lifecycle_configuration.this <bucket-name>
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count = var.lifetime_days > 0 ? 1 : 0

  bucket = aws_s3_bucket.this.id

  rule {
    id     = "Delete-${var.lifetime_days}-days"
    status = "Enabled" # TODO what happened to enabled

    filter {
      prefix = ""
    }

    expiration {
      days = var.lifetime_days # TODO is this the same value?
    }
  }
}

# terraform import module.<name>.aws_s3_bucket_cors_configuration.this <bucket-name>
resource "aws_s3_bucket_cors_configuration" "this" {
  count = var.cors_rule != null ? 1 : 0

  bucket = aws_s3_bucket.this.id

  cors_rule {
    allowed_methods = var.cors_rule.allowed_methods
    allowed_origins = var.cors_rule.allowed_origins
    allowed_headers = try(var.cors_rule.allowed_headers, null)
    expose_headers  = try(var.cors_rule.expose_headers, null)
    max_age_seconds = try(var.cors_rule.max_age_seconds, null)
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = var.bucket_policy != null ? 1 : 0

  bucket = aws_s3_bucket.this.id

  policy = jsonencode(
    merge(var.bucket_policy, {
      Statement = [
        for statement in var.bucket_policy.Statement : merge(statement, {
          Resource = (
            try(
              [
                for resource in statement.Resource :
                try(format(resource, var.bucket_name), resource)
              ],
              try(format(statement.Resource, var.bucket_name), statement.Resource),
            )
          )
        })
      ]
    })
  )
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.block_public_access ? 1 : 0

  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}
