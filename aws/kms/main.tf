resource "aws_kms_alias" "this" {
  name = "alias/${local.names.fqn}"

  target_key_id = aws_kms_key.this.id
}

resource "aws_kms_key" "this" {
  description = "${local.names.fqn} KMS key"

  deletion_window_in_days = local.const.kms_deletion_window_in_days

  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"

  is_enabled          = true
  enable_key_rotation = true

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.this.account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      }
    ]
  })
}
