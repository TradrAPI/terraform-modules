output "role_name" {
  description = "The IAM role nae for Kafka Connect."
  value       = aws_iam_role.this.name
}
