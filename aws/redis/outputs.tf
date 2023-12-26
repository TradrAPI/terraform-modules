output "sg-redis" {
    value = aws_security_group.redis.id
}

output "endpoint" {
    value = (
      var.cluster_mode != null
      ? aws_elasticache_replication_group.redis.configuration_endpoint_address
      : aws_elasticache_replication_group.redis.primary_endpoint_address
    )
}
