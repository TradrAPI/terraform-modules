<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | ../kms | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_msk_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster) | resource |
| [aws_msk_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_configuration) | resource |
| [aws_msk_scram_secret_association.users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_scram_secret_association) | resource |
| [aws_secretsmanager_secret.msk_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.msk_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_version.msk_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.msk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_password.msk](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.msk_users](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | Allowed CIDR blocks that can access the MSK cluster | `list(string)` | `[]` | no |
| <a name="input_client_subnets"></a> [client\_subnets](#input\_client\_subnets) | Client VPC subnets | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | MSK cluster name | `string` | `null` | no |
| <a name="input_default_num_partitions"></a> [default\_num\_partitions](#input\_default\_num\_partitions) | Default number of partitions (>= number\_of\_broker\_nodes is recommended) | `number` | `null` | no |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | EBS volume size (in GiB) for each broker node | `number` | `10` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `null` | no |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Kafka version (See https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html) | `string` | `"3.4.0"` | no |
| <a name="input_msk_instance_type"></a> [msk\_instance\_type](#input\_msk\_instance\_type) | MSK instance type (See https://docs.aws.amazon.com/msk/latest/developerguide/broker-instance-sizes.html) | `string` | `"kafka.t3.small"` | no |
| <a name="input_number_of_broker_nodes"></a> [number\_of\_broker\_nodes](#input\_number\_of\_broker\_nodes) | Number of broker nodes | `number` | `3` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | Platform name | `string` | `null` | no |
| <a name="input_server_properties"></a> [server\_properties](#input\_server\_properties) | Server properties. You can specify any of the properties in https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html.<br/><br/>Example:<pre>server_properties = <<-EOF2<br/>  auto.create.topics.enable=true<br/>  delete.topic.enable=true<br/>EOF2</pre> | `string` | `null` | no |
| <a name="input_users"></a> [users](#input\_users) | MSK users names list (passwords are generated automatically) | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the MSK cluster will be created | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_msk_brokers_by_auth_method"></a> [msk\_brokers\_by\_auth\_method](#output\_msk\_brokers\_by\_auth\_method) | Map of brokers list by authentication method. The list on each key is a comma-separated list of brokers |
| <a name="output_msk_sasl_scram_users"></a> [msk\_sasl\_scram\_users](#output\_msk\_sasl\_scram\_users) | Map of user names to their passwords |
<!-- END_TF_DOCS -->
