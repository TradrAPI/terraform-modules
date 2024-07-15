module "msk_s3_bkp" {
  source = "github.com/TradrApi/terraform-modules//aws/s3?ref=v1"

  bucket_name = "${var.environment}-${var.platform}-msk-backup"

  block_public_access = true
  create_bucket_acl   = false
}



resource "aws_security_group" "s3_sink_connector" {
  name   = "${var.platform}-${var.environment}-amazon-s3-sink-connector"
  vpc_id = var.vpc_id
}


resource "aws_cloudwatch_log_group" "s3_sink_connector" {
  name              = "${var.platform}-${var.environment}/amazon-msk-s3-sink-connector"
  retention_in_days = 3
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




resource "aws_s3_bucket_server_side_encryption_configuration" "msk_s3_bkp" {
  bucket = module.msk_s3_bkp.bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


data "aws_caller_identity" "this" {}

resource "aws_iam_role" "msk_s3_bkp" {
  name = replace(title("${var.platform}-msk-bkp-role"), "-", "")

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "kafkaconnect.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
        "Condition" : {
          "StringEquals" : {
            "aws:SourceAccount" : data.aws_caller_identity.this.account_id
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "msk_s3_bkp" {
  name = replace(title("${var.platform}-msk-bkp-policy"), "-", "")

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListAllMyBuckets"
        ],
        "Resource" : "arn:aws:s3:::*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ],
        "Resource" : "arn:aws:s3:::${module.msk_s3_bkp.bucket.id}"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:AbortMultipartUpload",
          "s3:PutObjectTagging"
        ],
        "Resource" : "arn:aws:s3:::${module.msk_s3_bkp.bucket.id}/*"
      },
      # See https://repost.aws/knowledge-center/msk-connector-connect-errors for the below rules
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:Connect",
          "kafka-cluster:DescribeCluster"
        ],
        "Resource" : [
          aws_msk_cluster.this.arn
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:ReadData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:WriteData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:CreateTopic",
          "kafka-cluster:WriteData",
          "kafka-cluster:ReadData",
          "kafka-cluster:DescribeTopic"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "kafka-cluster:AlterGroup",
          "kafka-cluster:DescribeGroup"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}




resource "aws_iam_role_policy_attachment" "msk_s3_bkp" {
  policy_arn = aws_iam_policy.msk_s3_bkp.arn
  role       = aws_iam_role.msk_s3_bkp.name
}



resource "aws_mskconnect_connector" "backup_msk_to_s3" {
  name                 = "${var.platform}-msk-bkp-to-s3"
  kafkaconnect_version = "2.7.1"

  capacity {
    autoscaling {
      mcu_count        = 1
      max_worker_count = 2
      min_worker_count = 1

      scale_in_policy {
        cpu_utilization_percentage = 10
      }

      scale_out_policy {
        cpu_utilization_percentage = 80
      }
    }
  }

  connector_configuration = {
    "s3.region"                      = var.region
    "s3.bucket.name"                 = module.msk_s3_bkp.bucket_id
    "connector.class"                = "io.confluent.connect.s3.S3SinkConnector"
    "format.class"                   = "io.confluent.connect.s3.format.json.JsonFormat"
    "flush.size"                     = "1"
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

  kafka_cluster {
    apache_kafka_cluster {
      bootstrap_servers = aws_msk_cluster.this.bootstrap_brokers_sasl_iam

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
      arn      = aws_mskconnect_custom_plugin.plugins["amazon-s3-sink-connector"].arn
      revision = aws_mskconnect_custom_plugin.plugins["amazon-s3-sink-connector"].latest_revision
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

  service_execution_role_arn = aws_iam_role.msk_s3_bkp.arn
}



