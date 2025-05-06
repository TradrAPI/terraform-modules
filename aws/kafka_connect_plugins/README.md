<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_plugins_bucket"></a> [plugins\_bucket](#module\_plugins\_bucket) | ../s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_mskconnect_custom_plugin.plugins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mskconnect_custom_plugin) | resource |
| [aws_s3_object.plugins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [terraform_data.plugins](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [aws_s3_bucket.plugins](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the bucket to store plugins | `string` | `""` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Whether to create the plugins bucket | `bool` | `true` | no |
| <a name="input_plugins"></a> [plugins](#input\_plugins) | Map of plugins names to configs | <pre>map(object({<br/>    url   = string<br/>    alias = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of the bucket to store the plugins |
| <a name="output_plugins"></a> [plugins](#output\_plugins) | A map of plugins names to their resource objects |
<!-- END_TF_DOCS -->