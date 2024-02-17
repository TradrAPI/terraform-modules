output "this" {
  value = aws_db_instance.this
}

output "sg" {
  value = aws_security_group.this
}

output "enhanced_monitoring_role_arn" {
  value = aws_iam_role.enhanced_monitoring[0].arn
}
