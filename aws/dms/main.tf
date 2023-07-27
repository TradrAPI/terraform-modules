resource "aws_dms_replication_subnet_group" "default" {
  replication_subnet_group_id = var.subnet_group.id
  subnet_ids                  = var.subnet_group.subnet_ids

  replication_subnet_group_description = "DMS Subnet group"
}

resource "aws_dms_replication_instance" "default" {
  replication_instance_class   = var.replication_instance.class
  allocated_storage            = var.replication_instance.allocated_storage
  availability_zone            = var.replication_instance.availability_zone
  engine_version               = var.replication_instance.engine_version
  preferred_maintenance_window = var.replication_instance.preferred_maintenance_window
  multi_az                     = var.replication_instance.multi_az

  apply_immediately          = true
  auto_minor_version_upgrade = true
  publicly_accessible        = false

  replication_subnet_group_id = aws_dms_replication_subnet_group.default.id
  replication_instance_id     = var.replication_instance.name

  vpc_security_group_ids = var.replication_instance.vpc_security_group_ids

  tags = {
    Name = var.replication_instance.name
  }
}

resource "aws_dms_endpoint" "sources" {
  for_each = var.sources

  database_name               = each.value.database_name
  endpoint_id                 = each.value.endpoint_id
  engine_name                 = each.value.engine_name
  username                    = each.value.username
  password                    = each.value.password
  port                        = each.value.port
  server_name                 = each.value.server_name
  ssl_mode                    = each.value.ssl_mode
  extra_connection_attributes = each.value.extra_connection_attributes

  endpoint_type = "source"

  tags = {
    Name = each.value.name
  }
}

resource "aws_dms_endpoint" "targets" {
  for_each = var.targets

  database_name               = each.value.database_name
  endpoint_id                 = each.value.endpoint_id
  engine_name                 = each.value.engine_name
  username                    = each.value.username
  password                    = each.value.password
  port                        = each.value.port
  server_name                 = each.value.server_name
  ssl_mode                    = each.value.ssl_mode
  extra_connection_attributes = each.value.extra_connection_attributes

  endpoint_type = "target"

  tags = {
    Name = each.value.name
  }
}

resource "aws_dms_replication_task" "replication" {
  for_each = var.replication_tasks

  migration_type            = each.value.migration_type
  replication_task_settings = each.value.replication_task_settings
  replication_task_id       = each.value.replication_task_id
  table_mappings            = each.value.table_mappings

  source_endpoint_arn = aws_dms_endpoint.sources[each.value.source_endpoint].endpoint_arn
  target_endpoint_arn = aws_dms_endpoint.targets[each.value.target_endpoint].endpoint_arn

  replication_instance_arn = aws_dms_replication_instance.default.replication_instance_arn

  tags = {
    Name = each.value.name
  }

  lifecycle {
    ignore_changes = [replication_task_settings]
  }
}
