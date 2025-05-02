module "kms" {
  source = "../kms"

  name = "${terraform.workspace}-msk-sasl-scam"

  create_user = false
}

resource "aws_secretsmanager_secret" "msk_users" {
  for_each = toset(var.users)

  kms_key_id = module.kms.key.id

  name                    = "AmazonMSK_${replace(title(each.value), "-", "_")}"
  description             = "MSK user ${each.value}"
  recovery_window_in_days = 0
}

resource "aws_msk_scram_secret_association" "users" {
  cluster_arn     = aws_msk_cluster.this.arn
  secret_arn_list = values(aws_secretsmanager_secret.msk_users).*.arn
}

data "aws_iam_policy_document" "msk_users" {
  for_each = toset(var.users)

  statement {
    sid    = "AWSKafkaResourcePolicy${replace(title(each.value), "-", "")}"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["kafka.amazonaws.com"]
    }

    actions   = ["secretsmanager:getSecretValue"]
    resources = [aws_secretsmanager_secret.msk_users[each.value].arn]
  }
}

resource "aws_secretsmanager_secret_policy" "msk_users" {
  for_each = toset(var.users)

  secret_arn = aws_secretsmanager_secret.msk_users[each.value].arn
  policy     = data.aws_iam_policy_document.msk_users[each.value].json
}

resource "random_password" "msk" {
  for_each = toset(var.users)

  length  = 32
  special = false

  lifecycle {
    ignore_changes = [
      special
    ]
  }
}

resource "aws_secretsmanager_secret_version" "msk_users" {
  for_each = toset(var.users)

  secret_id = aws_secretsmanager_secret.msk_users[each.value].id

  secret_string = jsonencode({
    username = each.value
    password = random_password.msk[each.value].result
  })
}
