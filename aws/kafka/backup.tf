module "msk_backup" {
  source = "../kafka_backup"

  resources_prefix = "${var.platform}-${var.environment}"

  create_backup_bucket = true
  bucket_lifetime_days = 14


  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  msk_cluster         = aws_msk_cluster.this
  plugins_bucket_name = module.mskconnect_plugins.bucket_name

  connector = {
    kafkaconnect_version  = "2.7.1"
    log_retention_in_days = 3

    capacity_autoscaling = {
      mcu_count        = 1
      max_worker_count = 2
      min_worker_count = 1

      scale_in_cpu_utilization_percentage  = 10
      scale_out_cpu_utilization_percentage = 80
    }

    connector_configuration = {
      "format.class"                   = "io.confluent.connect.s3.format.json.JsonFormat"
      "flush.size"                     = "3"
      "schema.compatibility"           = "NONE"
      "tasks.max"                      = "2"
      "partitioner.class"              = "io.confluent.connect.storage.partitioner.DefaultPartitioner"
      "storage.class"                  = "io.confluent.connect.s3.storage.S3Storage"
      "topics.dir"                     = "topics"
      "topics.regex"                   = "^(?!__).*"
      "behavior.on.null.values"        = "ignore"
      "value.converter"                = "org.apache.kafka.connect.json.JsonConverter"
      "value.converter.schemas.enable" = "false"
    }
  }
}

moved {
  from = module.msk_s3_bkp
  to   = module.msk_backup.module.backup_bucket[0]
}

moved {
  from = aws_security_group.s3_sink_connector
  to   = module.msk_backup.aws_security_group.s3_sink_connector
}

moved {
  from = aws_cloudwatch_log_group.s3_sink_connector
  to   = module.msk_backup.aws_cloudwatch_log_group.s3_sink_connector
}

moved {
  from = aws_security_group_rule.s3_sink_connector_outbound
  to   = module.msk_backup.aws_security_group_rule.s3_sink_connector_outbound
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.msk_s3_bkp
  to   = module.msk_backup.aws_s3_bucket_server_side_encryption_configuration.backup_bucket
}

moved {
  from = aws_iam_role.msk_s3_bkp
  to   = module.msk_backup.aws_iam_role.backup
}

moved {
  from = aws_iam_policy.msk_s3_bkp
  to   = module.msk_backup.aws_iam_policy.backup
}

moved {
  from = aws_iam_role_policy_attachment.msk_s3_bkp
  to   = module.msk_backup.aws_iam_role_policy_attachment.backup
}

moved {
  from = aws_mskconnect_connector.backup_msk_to_s3
  to   = module.msk_backup.aws_mskconnect_connector.backup_msk_to_s3
}

module "mskconnect_plugins" {
  source = "../kafka_plugins"

  bucket_name   = "${var.environment}-${var.platform}-mskconnect-custom-plugins"
  create_bucket = true

  plugins = {
    # Write data from kafka to s3 backup
    "amazon-s3-sink-connector" = {
      alias = "${var.platform}-${var.environment}-amazon-s3-sink-connector"
      url   = var.amazon_s3_sink_connector_url
    }
  }
}

moved {
  from = module.mskconnect_custom_plugins
  to   = module.mskconnect_plugins.module.plugins_bucket[0]
}

moved {
  from = aws_s3_object.plugins
  to   = module.mskconnect_plugins.aws_s3_object.plugins
}

moved {
  from = aws_mskconnect_custom_plugin.plugins
  to   = module.mskconnect_plugins.aws_mskconnect_custom_plugin.plugins
}

moved {
  from = terraform_data.plugins
  to   = module.mskconnect_plugins.terraform_data.plugins
}
