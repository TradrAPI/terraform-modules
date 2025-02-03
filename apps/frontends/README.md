<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | 3.29.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 3.29.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_artifact_bucket"></a> [artifact\_bucket](#module\_artifact\_bucket) | ../../aws/s3 | n/a |
| <a name="module_bucket"></a> [bucket](#module\_bucket) | ../../aws/s3 | n/a |
| <a name="module_infra_store"></a> [infra\_store](#module\_infra\_store) | ../../utils/infra_store | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.brands](https://registry.terraform.io/providers/cloudflare/cloudflare/3.29.0/docs/resources/record) | resource |
| [cloudflare_ruleset.cache_rules_api](https://registry.terraform.io/providers/cloudflare/cloudflare/3.29.0/docs/resources/ruleset) | resource |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |
| [cloudflare_zone.this](https://registry.terraform.io/providers/cloudflare/cloudflare/3.29.0/docs/data-sources/zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_allow_record_overwrite"></a> [allow\_record\_overwrite](#input\_allow\_record\_overwrite) | n/a | `bool` | `false` | no |
| <a name="input_allowed_source_ips"></a> [allowed\_source\_ips](#input\_allowed\_source\_ips) | n/a | `list(string)` | `[]` | no |
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | n/a | `bool` | `false` | no |
| <a name="input_create_artifact_bucket"></a> [create\_artifact\_bucket](#input\_create\_artifact\_bucket) | n/a | `bool` | `false` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | n/a | `bool` | `true` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | n/a | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | n/a | yes |
| <a name="input_partitions"></a> [partitions](#input\_partitions) | n/a | `map(map(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_artifact_bucket"></a> [artifact\_bucket](#output\_artifact\_bucket) | n/a |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | n/a |
| <a name="output_projects"></a> [projects](#output\_projects) | n/a |
<!-- END_TF_DOCS -->