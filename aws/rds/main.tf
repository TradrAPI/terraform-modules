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

moved {
  from = aws_db_subnet_group.this
  to   = aws_db_subnet_group.this[0]
}

resource "aws_db_instance" "this" {
  identifier        = local.db_identifier
  db_name           = local.db_name
  allocated_storage = var.allocated_storage
  instance_class    = var.instance_class
  engine_version    = var.engine_version
  tags              = var.tags

  performance_insights_enabled = var.performance_insights_enabled
  username                     = var.username
  password                     = var.password
  manage_master_user_password  = var.manage_master_user_password

  # Safety good practices
  # - A final snapshot is always taken
  # - automated backups are always retained
  final_snapshot_identifier = coalesce(var.final_snapshot_identifier, "${local.db_identifier}-final-snapshot")
  delete_automated_backups  = false
  skip_final_snapshot       = false

  snapshot_identifier             = var.snapshot_identifier
  storage_type                    = var.storage_type
  storage_encrypted               = var.storage_encrypted
  iops                            = var.iops
  storage_throughput              = var.storage_throughput
  engine                          = var.engine
  backup_retention_period         = var.backup_retention_period
  deletion_protection             = var.deletion_protection
  publicly_accessible             = var.publicly_accessible
  apply_immediately               = var.apply_immediately
  parameter_group_name            = var.parameter_group
  multi_az                        = var.multi_az
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  db_subnet_group_name = try(aws_db_subnet_group.this[0].id, null)

  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = local.monitoring_role_arn

  max_allocated_storage = var.max_allocated_storage

  replicate_source_db = var.replicate_source_db

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

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
