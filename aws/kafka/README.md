<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_msk_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster) | resource |
| [aws_msk_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_configuration) | resource |
| [aws_security_group.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | Allowed CIDR blocks. | `list(string)` | `[]` | no |
| <a name="input_client_subnets"></a> [client\_subnets](#input\_client\_subnets) | Client subnets. | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | msk cluster name. | `string` | `null` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | EBS volume size. | `number` | `10` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name. | `string` | `null` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Kafka version. | `string` | `"3.4.0"` | no |
| <a name="input_msk_instance_type"></a> [msk\_instance\_type](#input\_msk\_instance\_type) | MSK instance type. | `string` | `"kafka.t3.small"` | no |
| <a name="input_number_of_broker_nodes"></a> [number\_of\_broker\_nodes](#input\_number\_of\_broker\_nodes) | Number of broker nodes. | `number` | `3` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | Platform name. | `string` | `null` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | Security groups. | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id. where the MSK cluster will be created. | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->