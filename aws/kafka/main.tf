locals {
  server_properties = join("\n", concat(
    local._server_properties_good_defaults,
    local._server_properties_without_locally_provided,
  ))

  _server_properties_good_defaults = [
    "num.partitions=${coalesce(var.default_num_partitions, 3 * var.number_of_broker_nodes)}",
    "log.retention.hours=168",
  ]

  _server_properties_without_locally_provided = [
    for property in split("\n", var.server_properties) :
    property
    if(
      property != ""
      && !startswith("log.retention.hours=", property)
      && !startswith("num.partitions=", property)
    )
  ]
}

resource "aws_msk_configuration" "this" {
  kafka_versions = [var.kafka_version]

  name = "${var.platform}-${var.environment}-${replace(var.kafka_version, ".", "")}"

  server_properties = local.server_properties

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "msk" {
  name              = "${terraform.workspace}/msk"
  retention_in_days = 7
}

resource "aws_msk_cluster" "this" {
  cluster_name  = var.cluster_name
  kafka_version = var.kafka_version

  number_of_broker_nodes = var.number_of_broker_nodes

  configuration_info {
    # create before
    arn      = aws_msk_configuration.this.arn
    revision = aws_msk_configuration.this.latest_revision
  }

  broker_node_group_info {
    client_subnets = var.client_subnets

    instance_type = var.msk_instance_type

    storage_info {
      ebs_storage_info {
        volume_size = var.ebs_volume_size
      }
    }

    security_groups = [aws_security_group.msk.id]
  }

  client_authentication {
    sasl {
      iam   = true
      scram = true
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "TLS"
    }
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }

      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk.name
      }
    }
  }
}

resource "aws_security_group" "msk" {
  name        = var.cluster_name
  description = "MSK security group"
  vpc_id      = var.vpc_id

  lifecycle {
    ignore_changes = [
      description
    ]
  }
}


resource "aws_security_group_rule" "msk" {
  for_each = {
    # See https://docs.aws.amazon.com/msk/latest/developerguide/port-info.html
    sasl_scram = {
      port        = 9096
      description = "SASL/SCRAM"
    }

    iam = {
      port        = 9098
      description = "IAM"
    }

    # See https://docs.aws.amazon.com/msk/latest/developerguide/open-monitoring.html
    jmx_exporter = {
      port        = 11001
      description = "JMX exporter"
    }

    node_exporter = {
      port        = 11002
      description = "Node exporter"
    }
  }

  security_group_id = aws_security_group.msk.id
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr_blocks

  description = each.value.description
  from_port   = each.value.port
  to_port     = each.value.port

  type = "ingress"
}
