terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


resource "aws_secretsmanager_secret" "secret" {
  name                    = "${var.name}"
  description             = "Secrets for ${var.name}"
  recovery_window_in_days = 0
  kms_key_id              = var.kms_key_id

}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = var.secret
}
