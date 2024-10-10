locals {
  db_identifier = "${var.resources_prefix}-db"
  db_name       = var.name
  db_sg         = "${var.resources_prefix}-db-sg"

  monitoring_role_arn = try(data.aws_iam_role.enhanced_monitoring[0].arn, aws_iam_role.enhanced_monitoring[0].arn)
}

resource "aws_db_subnet_group" "this" {
  count = var.replicate_source_db == null ? 1 : 0

  description = "Subnet group for ${local.db_identifier} DB instance"
  subnet_ids  = var.vpc.subnets
}

resource "aws_db_parameter_group" "master" {
  name   = "${var.parameter_group}"
  family = "${var.family}"

  parameter {
    name  = "auto_explain.log_min_duration"
    value = "10"
  }

  parameter {
    name  = "auto_explain.log_nested_statements"
    value = "1"
  }

  parameter {
    name  = "wal_compression"
    value = "on"
  }

  parameter {
    name  = "wal_keep_size"
    value = "10240"
  }

  parameter {
    name          = "shared_preload_libraries"
    value         = "pg_stat_statements,auto_explain"
    apply_method  = "pending-reboot"
  }

  parameter {
    name          = "rds.logical_replication"
    apply_method  = "pending-reboot"
    value         = var.logical_replication
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_instance" "this" {
  identifier                     = local.db_identifier
  db_name                        = local.db_name
  allocated_storage              = var.allocated_storage
  instance_class                 = var.instance_class
  engine_version                 = var.engine_version
  tags                           = var.tags

  performance_insights_enabled   = var.performance_insights_enabled
  username                       = var.username
  password                       = var.password
  manage_master_user_password    = var.manage_master_user_password

  final_snapshot_identifier      = coalesce(var.final_snapshot_identifier, "${local.db_identifier}-final-snapshot")
  delete_automated_backups       = false
  skip_final_snapshot            = false

  snapshot_identifier            = var.snapshot_identifier
  storage_type                   = var.storage_type
  storage_encrypted              = var.storage_encrypted
  iops                           = var.iops
  storage_throughput             = var.storage_throughput
  engine                         = var.engine
  backup_retention_period        = var.backup_retention_period
  deletion_protection            = var.deletion_protection
  publicly_accessible            = var.publicly_accessible
  apply_immediately              = var.apply_immediately
  parameter_group_name           = aws_db_parameter_group.master.name
  multi_az                       = var.multi_az
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  availability_zone = var.availability_zone
  maintenance_window = var.maintenance_window
  performance_insights_retention_period = var.performance_insights_retention_period
  vpc_security_group_ids = var.vpc_security_group_ids


  db_subnet_group_name = try(aws_db_subnet_group.this[0].id, null)

  monitoring_interval  = var.monitoring_interval
  monitoring_role_arn  = local.monitoring_role_arn

  max_allocated_storage = var.max_allocated_storage

  ca_cert_identifier = var.ca_cert_identifier

  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
}

resource "aws_security_group" "this" {
  name        = local.db_sg
  description = "Allows ${local.db_identifier} DB instance access"
  vpc_id      = var.vpc.id
}

resource "aws_security_group_rule" "access_from_vpc" {
  security_group_id = aws_security_group.this.id
  from_port         = aws_db_instance.this.port
  to_port           = aws_db_instance.this.port

  type        = "ingress"
  description = "Access ${local.db_identifier} DB from within VPC"
  protocol    = "tcp"

  cidr_blocks = [var.vpc.cidr]
}

# Replica config

# resource "aws_db_parameter_group" "replica" {
#   name   = "${var.parameter_group}-replica"
#   family = "${var.family}"

#   parameter {
#     name  = "max_standby_archive_delay"
#     value = "300000"
#   }
#   parameter {
#     name  = "max_standby_streaming_delay"
#     value = "300000"
#   }

#   parameter {
#     name  = "statement_timeout"
#     value = var.replica_statement_timeout
#   }

#   parameter {
#     name  = "idle_in_transaction_session_timeout"
#     value = "600000"
#   }

#   parameter {
#     name  = "hot_standby_feedback"
#     value = "1"
#   }

#   parameter {
#     name  = "wal_compression"
#     value = "on"
#   }

#   parameter {
#     name  = "auto_explain.log_min_duration"
#     value = "5"
#   }

#   parameter {
#     name  = "auto_explain.log_nested_statements"
#     value = "1"
#   }

#   parameter {
#     name  = "wal_keep_size"
#     value = "10240"
#   }

#   parameter {
#     name          = "shared_preload_libraries"
#     value         = "pg_stat_statements,auto_explain"
#     apply_method  = "pending-reboot"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_db_instance" "replica" {
#   replicate_source_db          = var.source_db_instance_id
#   backup_retention_period      = var.backup_retention_period
#   parameter_group_name         = aws_db_parameter_group.replica.name
#   performance_insights_enabled = "true"
#   publicly_accessible          = var.publicly_accessible
#   iops                         = var.iops
#   storage_throughput           = var.storage_throughput
#   allocated_storage            = var.allocated_storage
#   max_allocated_storage        = var.max_allocated_storage
#   storage_encrypted            = var.storage_encrypted
#   monitoring_interval          = var.monitoring_interval
#   delete_automated_backups     = false
#   skip_final_snapshot          = false
#   monitoring_role_arn          = local.monitoring_role_arn
#   storage_type                 = "gp3"
#   engine                       = "postgres"
#   engine_version               = var.engine_version
#   identifier                   = "${local.db_identifier}-replica"
#   instance_class               = var.instance_class_replica
#   multi_az                     = var.multi_az

#   deletion_protection          = true
#   apply_immediately            = true
#   ca_cert_identifier           = "rds-ca-rsa2048-g1"
# }
