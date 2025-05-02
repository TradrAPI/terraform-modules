output "role" {
  description = "The IAM role for Kafka Connect."
  value       = aws_iam_role.this.arn
}
