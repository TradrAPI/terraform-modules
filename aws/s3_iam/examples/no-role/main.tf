provider "aws" {
  region = "us-west-2"
}

module "bucket" {
  source = "../../../S3"

  brand             = "internal"
  deployment_env    = "dev"
  s3_bucket_content = "test-content"
  force_destroy     = true
}

module "bucket_iam" {
  source = "../.."

  bucket_id = module.bucket.bucket_id

  policy = "TestContentReadWrite"
  group  = "TestContentS3"
  user   = "test-content.admin"
}