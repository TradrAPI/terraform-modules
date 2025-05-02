<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | ../../aws/s3 | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | terraform-aws-modules/lambda/aws | 7.2.5 |

## Resources

| Name | Type |
|------|------|
| [random_password.turbo_token](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_lambda"></a> [create\_lambda](#input\_create\_lambda) | n/a | `bool` | `true` | no |
| <a name="input_extra_environment_variables"></a> [extra\_environment\_variables](#input\_extra\_environment\_variables) | n/a | `map(string)` | `{}` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | n/a | `list(string)` | `[]` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | n/a | `number` | `128` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the Bucket and Lambda function | `string` | n/a | yes |
| <a name="input_pre_commands"></a> [pre\_commands](#input\_pre\_commands) | n/a | `list(string)` | `[]` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | n/a | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lambda_function_url"></a> [lambda\_function\_url](#output\_lambda\_function\_url) | n/a |
| <a name="output_turbo_token"></a> [turbo\_token](#output\_turbo\_token) | n/a |
<!-- END_TF_DOCS -->