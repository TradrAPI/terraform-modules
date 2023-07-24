moved {
  from = aws_elasticache_cluster.redis
  to   = aws_elasticache_cluster.redis[0]
}
