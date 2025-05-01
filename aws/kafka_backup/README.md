<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backup_bucket"></a> [backup\_bucket](#module\_backup\_bucket) | ../s3 | n/a |
| <a name="module_mskconnect_plugin"></a> [mskconnect\_plugin](#module\_mskconnect\_plugin) | ../kafka_plugins | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.s3_sink_connector](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.backup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_mskconnect_connector.backup_msk_to_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mskconnect_connector) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.backup_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_security_group.s3_sink_connector](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.s3_sink_connector_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_bucket_name"></a> [backup\_bucket\_name](#input\_backup\_bucket\_name) | The name of the S3 bucket to store the backups | `string` | `""` | no |
| <a name="input_bucket_lifetime_days"></a> [bucket\_lifetime\_days](#input\_bucket\_lifetime\_days) | The number of days to keep the backups in the S3 bucket | `number` | `14` | no |
| <a name="input_connector"></a> [connector](#input\_connector) | n/a | <pre>object({<br/>    kafkaconnect_version  = optional(string, "2.7.1")<br/>    log_retention_in_days = optional(number, 3)<br/><br/>    sink_connector_url = optional(<br/>      string,<br/>      "https://d2p6pa21dvn84.cloudfront.net/api/plugins/confluentinc/kafka-connect-s3/versions/10.5.2/confluentinc-kafka-connect-s3-10.5.2.zip"<br/>    )<br/><br/>    capacity_autoscaling = object({<br/>      mcu_count        = optional(number, 1)<br/>      max_worker_count = optional(number, 2)<br/>      min_worker_count = optional(number, 1)<br/><br/>      scale_in_cpu_utilization_percentage  = optional(number, 10)<br/>      scale_out_cpu_utilization_percentage = optional(number, 80)<br/>    })<br/><br/>    connector_configuration = optional(map(string), {<br/>      "format.class"                   = "io.confluent.connect.s3.format.json.JsonFormat"<br/>      "flush.size"                     = "1"<br/>      "schema.compatibility"           = "NONE"<br/>      "tasks.max"                      = "2"<br/>      "partitioner.class"              = "io.confluent.connect.storage.partitioner.DefaultPartitioner"<br/>      "storage.class"                  = "io.confluent.connect.s3.storage.S3Storage"<br/>      "topics.dir"                     = "topics"<br/>      "topics.regex"                   = "^(?!__).*"<br/>      "behavior.on.null.values"        = "ignore"<br/>      "value.converter"                = "org.apache.kafka.connect.json.JsonConverter"<br/>      "value.converter.schemas.enable" = "false"<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_create_backup_bucket"></a> [create\_backup\_bucket](#input\_create\_backup\_bucket) | Whether to create the S3 bucket to store the backups | `bool` | `true` | no |
| <a name="input_kafkaconnect_version"></a> [kafkaconnect\_version](#input\_kafkaconnect\_version) | The version of the Kafka Connect to use in the connector | `string` | `"2.7.1"` | no |
| <a name="input_log_retention_in_days"></a> [log\_retention\_in\_days](#input\_log\_retention\_in\_days) | The number of days to keep the logs in CloudWatch | `number` | `3` | no |
| <a name="input_msk_cluster"></a> [msk\_cluster](#input\_msk\_cluster) | The MSK cluster to backup. A cluster resource object can be passed directly | <pre>object({<br/>    arn                        = string<br/>    bootstrap_brokers_sasl_iam = string<br/>  })</pre> | n/a | yes |
| <a name="input_plugins_bucket_name"></a> [plugins\_bucket\_name](#input\_plugins\_bucket\_name) | The name of the S3 bucket to store the plugins | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets to deploy the connector in | `list(string)` | `[]` | no |
| <a name="input_resources_prefix"></a> [resources\_prefix](#input\_resources\_prefix) | The prefix to use for the resources created by this module | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID to deploy the connector in | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->