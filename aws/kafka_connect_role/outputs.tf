output "role_name" {
  description = "The IAM role nae for Kafka Connect."
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "The ARN of the IAM role for Kafka Connect."
  value       = aws_iam_role.this.arn
}
