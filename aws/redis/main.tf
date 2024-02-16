terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.name}-subnet"
  subnet_ids = var.subnet
}

resource "aws_security_group" "redis" {
  vpc_id      = var.vpc
  name        = "${var.name}-sg"
  description = "Redis cache Security Group"
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}"
  }
}

resource "aws_elasticache_replication_group" "redis" {
  automatic_failover_enabled  = true
  preferred_cache_cluster_azs = local.az_zones
  replication_group_id        = var.name
  description                 = "redis cluster for ${var.platform}"
  node_type                   = "cache.${var.size}"
  num_cache_clusters          = local.num_cache_clusters
  port                        = var.port
  subnet_group_name           = aws_elasticache_subnet_group.redis.name
  security_group_ids          = [aws_security_group.redis.id]
  engine_version              = var.engine_version
  engine                      = "redis"
  multi_az_enabled            = var.multi_az_enabled
  tags                        = var.tags

  parameter_group_name = (
    var.parameter_group_name == null
    ? format(local.parameter_group_name_scheme, regex("^(\\d.\\w+)?", var.engine_version)[0])
    : var.parameter_group_name
  )

  num_node_groups         = try(var.cluster_mode.num_node_groups, null)
  replicas_per_node_group = try(var.cluster_mode.replicas_per_node_group, null)

  dynamic "log_delivery_configuration" {
    for_each = local.log_delivery_configuration

    content {
      destination      = log_delivery_configuration.value.destination
      destination_type = log_delivery_configuration.value.destination_type
      log_format       = log_delivery_configuration.value.log_format
      log_type         = log_delivery_configuration.value.log_type
    }
  }

  lifecycle {
    ignore_changes = [num_cache_clusters]
  }
}

resource "aws_elasticache_cluster" "redis" {
  count = var.cluster_mode == null ? 1 : 0

  cluster_id           = lower("${var.name}-cache")
  replication_group_id = aws_elasticache_replication_group.redis.id
}


resource "aws_security_group_rule" "service-redis" {
  count = var.security_group_id == null ? 0 : 1

  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  source_security_group_id = var.security_group_id
  security_group_id        = aws_security_group.redis.id
  description              = "VPC access"
}

moved {
  from = aws_security_group_rule.service-redis
  to   = aws_security_group_rule.service-redis[0]
}

locals {
  num_cache_clusters = (
    var.cluster_mode != null
    ? null
    : length(var.az_zones)
  )

  parameter_group_name_scheme = (
    var.cluster_mode != null
    ? "default.redis%s.cluster.on"
    : "default.redis%s"
  )

  az_zones = (
    var.cluster_mode != null
    ? null
    : var.az_zones
  )

  log_delivery_configuration = (
    var.log_delivery_configuration != null
    ? [var.log_delivery_configuration]
    : []
  )
}
