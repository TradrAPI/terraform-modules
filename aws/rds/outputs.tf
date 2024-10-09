output "this" {
  value = aws_db_instance.this
}

output "sg" {
  value = aws_security_group.this
}

output "enhanced_monitoring_role_arn" {
  value = var.create_monitoring_role ? aws_iam_role.enhanced_monitoring[0].arn : null
}

output "identifier" {
  value       = var.source_db_instance_id == null ? aws_db_instance.this[0].identifier : null
  description = "Identifier of the main DB instance"
}

output "replica_identifier" {
  value       = var.source_db_instance_id != null ? aws_db_instance.replica[0].identifier : null
  description = "Identifier of the replica DB instance"
}