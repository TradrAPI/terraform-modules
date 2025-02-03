## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of Redis Cluster | `string` | n/a | yes |
| nodes | number of nodes for redis cluster | `number` | n/a | yes |
| platform | Name of Platform or Brand | `string` | n/a | yes |
| port | port number for redis | `number` | n/a | yes |
| subnet | List of subnets ID For Redis subnet | `list(string)` | n/a | yes |
| vpc | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
| security\_id | n/a |
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_cluster.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_replication_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_security_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.service-redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_az_zones"></a> [az\_zones](#input\_az\_zones) | List of available Zones | `list(string)` | n/a | yes |
| <a name="input_cluster_mode"></a> [cluster\_mode](#input\_cluster\_mode) | n/a | <pre>object({<br/>    replicas_per_node_group = number<br/>    num_node_groups         = number<br/>  })</pre> | `null` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | version number of redis | `string` | n/a | yes |
| <a name="input_log_delivery_configuration"></a> [log\_delivery\_configuration](#input\_log\_delivery\_configuration) | n/a | <pre>object({<br/>    destination      = string<br/>    destination_type = string<br/>    log_format       = string<br/>    log_type         = string<br/>  })</pre> | `null` | no |
| <a name="input_multi_az_enabled"></a> [multi\_az\_enabled](#input\_multi\_az\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Redis Cluster | `string` | n/a | yes |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | n/a | `string` | `null` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | Name of Platform or Brand | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | port number for redis | `number` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The id of the general security group | `string` | `null` | no |
| <a name="input_size"></a> [size](#input\_size) | n/a | `string` | `"t2.small"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | List of subnets ID For Redis subnet | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_sg-redis"></a> [sg-redis](#output\_sg-redis) | n/a |
<!-- END_TF_DOCS -->