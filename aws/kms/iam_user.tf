resource "aws_iam_access_key" "kms" {
  count = var.create_user ? 1 : 0

  user = aws_iam_user.kms[0].name
}

resource "aws_iam_user_policy_attachment" "kms" {
  count = var.create_user ? 1 : 0

  user       = aws_iam_user.kms[0].name
  policy_arn = aws_iam_policy.kms[0].arn

  depends_on = [aws_iam_user.kms[0]]
}

resource "aws_iam_user" "kms" {
  count = var.create_user ? 1 : 0

  name          = local.names.kms_user
  force_destroy = true
}

resource "aws_iam_policy" "kms" {
  count = var.create_user ? 1 : 0

  name        = local.names.kms_policy
  description = "${local.names.fqn} service kms policy."

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : distinct(concat(var.default_permissions, var.extra_permissions)),
        "Resource" : aws_kms_key.this.arn
      }
    ]
  })
}
