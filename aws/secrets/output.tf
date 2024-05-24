output "arn" {
    value = aws_secretsmanager_secret.secret.arn
}

output "secret" {
    value = aws_secretsmanager_secret_version.secret.secret_string
    sensitive = true
}