output "subnet_group" {
  value = aws_dms_replication_subnet_group.default
}

output "replication_instance" {
  value = aws_dms_replication_instance.default
}

output "source_endpoints" {
  value = aws_dms_endpoint.sources
}

output "target_endpoints" {
  value = aws_dms_endpoint.targets
}

output "replication_tasks" {
  value = aws_dms_replication_task.replication
}
