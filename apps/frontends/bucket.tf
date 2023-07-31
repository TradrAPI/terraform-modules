module "bucket" {
  source = "../../aws/s3"

  count = var.create_bucket ? 1 : 0

  force_destroy = var.bucket_force_destroy
  bucket_name   = "${var.environment}-frontend-all"

  lifetime_days       = -1
  block_public_access = false

  bucket_policy = {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "GetObjectIPWhitelist",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::%s/*",
        "Condition" : {
          "IpAddress" : {
            "aws:SourceIp" : [
              for ip in var.allowed_source_ips : "${ip}/32"
            ]
          }
        }
      }
    ]
  }
}
