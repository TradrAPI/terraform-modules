provider "aws" {
  region = "us-west-2"
}

module "bucket" {
  source = "../.."

  bucket_name   = "minimalist-bucket"
  lifetime_days = 8
  force_destroy = true
}

module "bucket_no_expiration" {
  source = "../.."

  bucket_name = "no-expiration-web-bucket"

  force_destroy = true

  bucket_policy = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::%s/*"
        }
    ]
  }

  cors_rule = {
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    expose_headers  = ["ETag","x-amz-meta-custom-header"]
    max_age_seconds = 3000
  }
}
