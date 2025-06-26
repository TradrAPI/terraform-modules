# aws/rds module

Allows the provisioning of DB instances.

## Required variables

- `name` - DB name
- `username` - DB user name
- `password` - DB user password
- `resources_prefix` - resources will be created with this prefix
- `vpc` - VPC object
  - `id` - VPC id
  - `private_subnets` - list of the VPC private subnets
  - `cidr` - VPC ip range as cidr block notation

## Optional variables

- `allocated_storage` - Allocated DB storage in GiB.
- `instance_class` - DB instance class. See https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
- `tags` - DB tags
- `skip_final_snapshot` - Whether to take a DB snapshot before deleting the instance
- `storage_type` - DB storage type
- `storage_encrypted` - DB storage encryption enabled
- `iops` - DB IOPS
- `storage_throughput` - DB storage throughput
- `engine` - DB engine
- `engine_version` - DB engine version
- `backup_retention_period` - Number of days to keep DB backups
- `snapshot_identifier` - Specify a snapshot to create the DB instance from. Triggers recreation
- `final_snapshot_identifier` - If `skip_final_snapshot = false`, takes a snapshot with this name before deleting the DB instance. Only takes effect it `skip_final_snapshot` is set to `false` during DB creation
- `deletion_protection` - Whether to allow the DB instance to be deleted
- `ca_cert_identifier` - RDS certificate authority identifier

## Scope of this module

`aws_db_subnet_group`

`aws_db_instance`

`aws_security_group`

`aws_security_group_rule`

## Examples

```terraform
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "db" {
  source = "../.."

  resources_prefix    = "test-db-instance"
  name                = "testdbinstance"
  instance_class      = "db.t2.micro"
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "11.6"
  username            = "testdbuser"
  password            = "testdbpassword"
  allocated_storage   = 10
  skip_final_snapshot = true

  tags = {
    Name = "Test DB instance"
  }

  vpc = {
    id      = data.aws_vpc.default.id
    cidr    = data.aws_vpc.default.cidr_block
    subnets = data.aws_subnet_ids.default.ids
  }
}
```

## Outputs

- `this` - The `aws_db_instance` output for the db instance. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#attributes-reference .
- `sg` - The `aws_security_group` output for the db security group. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group .

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
| [aws_db_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.enhanced_monitoring-attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.access_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_role.enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_role) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | Allocated DB storage in GiB. | `number` | `10` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | n/a | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | n/a | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | n/a | `bool` | `false` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Backup retention period in days. | `number` | `30` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | n/a | `string` | `"rds-ca-rsa2048-g1"` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | n/a | `bool` | `false` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this is set to true. | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | n/a | `list(string)` | `[]` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | n/a | `string` | `"postgres"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `string` | `"11.6"` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | If skip\_final\_snapshot = false, takes a snapshot with this name before deleting the instance. | `string` | `null` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | DB instance class. | `string` | `"db.t2.micro"` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | n/a | `number` | `null` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | n/a | `string` | `null` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#managed-master-passwords-via-secrets-manager-default-kms-key | `bool` | `false` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | n/a | `number` | n/a | yes |
| <a name="input_monitoring_interval"></a> [monitoring\_interval](#input\_monitoring\_interval) | n/a | `number` | `15` | no |
| <a name="input_monitoring_role"></a> [monitoring\_role](#input\_monitoring\_role) | n/a | `string` | `"rds-monitoring-role"` | no |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | DB name. | `string` | `null` | no |
| <a name="input_parameter_group"></a> [parameter\_group](#input\_parameter\_group) | n/a | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | n/a | `string` | `null` | no |
| <a name="input_performance_insights_enabled"></a> [performance\_insights\_enabled](#input\_performance\_insights\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_publicly_accessible"></a> [publicly\_accessible](#input\_publicly\_accessible) | n/a | `bool` | `false` | no |
| <a name="input_replicate_source_db"></a> [replicate\_source\_db](#input\_replicate\_source\_db) | Specifies that this resource is a Replicate database, and to use this value as the source database. | `string` | `null` | no |
| <a name="input_resources_prefix"></a> [resources\_prefix](#input\_resources\_prefix) | Creates resources with this prefix. | `string` | n/a | yes |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specify a snapshot to create the DB instance from. Triggers recreation. | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | n/a | `bool` | `false` | no |
| <a name="input_storage_throughput"></a> [storage\_throughput](#input\_storage\_throughput) | n/a | `number` | `null` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | n/a | `string` | `"gp2"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | DB user name. | `string` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    id      = string<br/>    cidr    = string<br/>    subnets = optional(list(string), [])<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_enhanced_monitoring_role_arn"></a> [enhanced\_monitoring\_role\_arn](#output\_enhanced\_monitoring\_role\_arn) | n/a |
| <a name="output_sg"></a> [sg](#output\_sg) | n/a |
| <a name="output_this"></a> [this](#output\_this) | n/a |
<!-- END_TF_DOCS -->