module "bucket" {
  source = "../s3"

  bucket_name   = var.backup_agent.bucket.name
  lifetime_days = var.backup_agent.bucket.lifetime_days

  create_bucket_acl = false
  force_destroy     = false
}

module "secrets_bucket" {
  source = "../s3"

  bucket_name   = "${var.backup_agent.bucket.name}-secrets"
  lifetime_days = var.backup_agent.bucket.lifetime_days

  create_bucket_acl = false
  force_destroy     = false
}

module "bucket_iam" {
  count = var.prefer_bucket_role ? 0 : 1

  source = "../s3_iam"

  bucket_id = module.bucket.bucket_id

  policy = var.backup_agent.iam.policy
  group  = var.backup_agent.iam.group
  user   = var.backup_agent.iam.user
}

moved {
  from = module.bucket_iam
  to   = module.bucket_iam[0]
}

resource "aws_iam_instance_profile" "bucket_iam" {
  name = var.backup_agent.iam.instance_profile
  role = aws_iam_role.bucket_iam.name
}

resource "aws_iam_role_policy_attachment" "bucket_iam" {
  role       = aws_iam_role.bucket_iam.name
  policy_arn = aws_iam_policy.bucket_iam.arn
}

resource "aws_iam_role" "bucket_iam" {
  name = var.backup_agent.bucket.iam.role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = [
            "ec2.amazonaws.com"
          ]
        }
        Action = [
          "sts:AssumeRole"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "bucket_iam" {
  name = var.backup_agent.iam.policy

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          "arn:aws:s3:::${var.backup_agent.bucket.name}",
          "arn:aws:s3:::${var.backup_agent.bucket.name}/*",
          "arn:aws:s3:::${var.backup_agent.bucket.name}-secrets",
          "arn:aws:s3:::${var.backup_agent.bucket.name}-secrets/*"
        ]
      }
    ]
  })
}
