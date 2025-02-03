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
| [aws_dms_endpoint.sources](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_endpoint.targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint) | resource |
| [aws_dms_replication_instance.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_instance) | resource |
| [aws_dms_replication_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_subnet_group) | resource |
| [aws_dms_replication_task.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_replication_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_replication_instance"></a> [replication\_instance](#input\_replication\_instance) | n/a | <pre>object({<br/>    name              = string<br/>    class             = string<br/>    allocated_storage = number<br/><br/>    vpc_security_group_ids       = optional(list(string), [])<br/>    availability_zone            = optional(string)<br/>    engine_version               = optional(string)<br/>    preferred_maintenance_window = optional(string, "sun:10:30-sun:14:30")<br/>    multi_az                     = optional(bool, false)<br/>  })</pre> | n/a | yes |
| <a name="input_replication_tasks"></a> [replication\_tasks](#input\_replication\_tasks) | n/a | <pre>map(object({<br/>    name                      = string<br/>    replication_task_id       = string<br/>    source_endpoint           = string<br/>    target_endpoint           = string<br/>    table_mappings            = string<br/>    replication_task_settings = optional(string)<br/>    migration_type            = optional(string, "full-load-and-cdc")<br/>  }))</pre> | n/a | yes |
| <a name="input_sources"></a> [sources](#input\_sources) | n/a | <pre>map(object({<br/>    name        = string<br/>    endpoint_id = string<br/>    engine_name = string<br/>    username    = string<br/>    password    = string<br/>    server_name = string<br/>    port        = number<br/><br/>    database_name               = optional(string)<br/>    ssl_mode                    = optional(string, "none")<br/>    extra_connection_attributes = optional(string, "")<br/>  }))</pre> | `{}` | no |
| <a name="input_subnet_group"></a> [subnet\_group](#input\_subnet\_group) | n/a | <pre>object({<br/>    id         = string<br/>    subnet_ids = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_targets"></a> [targets](#input\_targets) | n/a | <pre>map(object({<br/>    name        = string<br/>    endpoint_id = string<br/>    engine_name = string<br/>    username    = string<br/>    password    = string<br/>    server_name = string<br/>    port        = number<br/><br/>    database_name               = optional(string)<br/>    ssl_mode                    = optional(string, "none")<br/>    extra_connection_attributes = optional(string, "")<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_replication_instance"></a> [replication\_instance](#output\_replication\_instance) | n/a |
| <a name="output_replication_tasks"></a> [replication\_tasks](#output\_replication\_tasks) | n/a |
| <a name="output_source_endpoints"></a> [source\_endpoints](#output\_source\_endpoints) | n/a |
| <a name="output_subnet_group"></a> [subnet\_group](#output\_subnet\_group) | n/a |
| <a name="output_target_endpoints"></a> [target\_endpoints](#output\_target\_endpoints) | n/a |
<!-- END_TF_DOCS -->