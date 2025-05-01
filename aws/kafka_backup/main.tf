resource "aws_mskconnect_connector" "backup_msk_to_s3" {
  name = "${var.resources_prefix}-msk-bkp-to-s3"

  kafkaconnect_version = var.connector.kafkaconnect_version

  capacity {
    autoscaling {
      mcu_count        = var.connector.capacity_autoscaling.mcu_count
      max_worker_count = var.connector.capacity_autoscaling.max_worker_count
      min_worker_count = var.connector.capacity_autoscaling.min_worker_count

      scale_in_policy {
        cpu_utilization_percentage = var.connector.capacity_autoscaling.scale_in_cpu_utilization_percentage
      }

      scale_out_policy {
        cpu_utilization_percentage = var.connector.capacity_autoscaling.scale_out_cpu_utilization_percentage
      }
    }
  }

  connector_configuration = merge(var.connector.connector_configuration, {
    "s3.region"       = data.aws_region.this.name
    "s3.bucket.name"  = local.bucket_name
    "connector.class" = "io.confluent.connect.s3.S3SinkConnector"
  })


  kafka_cluster {
    apache_kafka_cluster {
      bootstrap_servers = var.msk_cluster.bootstrap_brokers_sasl_iam

      vpc {
        security_groups = [aws_security_group.s3_sink_connector.id]
        subnets         = var.private_subnets
      }
    }
  }

  kafka_cluster_client_authentication {
    authentication_type = "IAM"
  }

  kafka_cluster_encryption_in_transit {
    encryption_type = "TLS"
  }

  plugin {
    custom_plugin {
      arn      = module.mskconnect_plugin.plugins["amazon-s3-sink-connector"].arn
      revision = module.mskconnect_plugin.plugins["amazon-s3-sink-connector"].latest_revision
    }
  }

  log_delivery {
    worker_log_delivery {
      cloudwatch_logs {
        log_group = aws_cloudwatch_log_group.s3_sink_connector.name
        enabled   = true
      }
    }
  }

  service_execution_role_arn = aws_iam_role.backup.arn
}

module "mskconnect_plugin" {
  source = "../kafka_plugins"

  bucket_name   = var.plugins_bucket_name
  create_bucket = false

  plugins = {
    "amazon-s3-sink-connector" = {
      alias = "${var.resources_prefix}-amazon-s3-sink-connector"
      url   = var.connector.sink_connector_url
    }
  }
}

resource "aws_security_group" "s3_sink_connector" {
  name   = "${var.resources_prefix}-amazon-s3-sink-connector"
  vpc_id = var.vpc_id
}

resource "aws_cloudwatch_log_group" "s3_sink_connector" {
  name              = "${var.resources_prefix}/amazon-msk-s3-sink-connector"
  retention_in_days = var.connector.log_retention_in_days
}

resource "aws_security_group_rule" "s3_sink_connector_outbound" {
  for_each = {
    all = {
      port        = 0
      description = "ALL"
    }
  }

  security_group_id = aws_security_group.s3_sink_connector.id
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]

  description = each.value.description
  from_port   = each.value.port
  to_port     = each.value.port

  type = "egress"
}
