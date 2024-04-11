module "bucket" {
  source = "../../aws/s3"

  bucket_name = var.bucket_name

  lifetime_days     = 7
  create_bucket_acl = false
}

resource "aws_iam_role" "turborepo_remote_cache" {
  name = var.role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "turborepo_remote_cache" {
  role = aws_iam_role.turborepo_remote_cache.id

  name = "${var.role_name}BucketAccess"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::${module.bucket.bucket_id}",
          "arn:aws:s3:::${module.bucket.bucket_id}/*"
        ]
      }
    ]
  })
}

module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.5"

  publish = true

  create_role = false

  function_name = var.lambda_name
  lambda_role   = aws_iam_role.turborepo_remote_cache

  handler = "index:handler"
  runtime = "node"

  source_path   = "${path.module}/lambda"
  artifacts_dir = "${path.root}/builds/package-dir/"
}
