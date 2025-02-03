# Terraform Secret module

## Example

```
module "apm_token_to" {
  source   = "github.com/TradrAPI/terraform-modules.git//aws/secrets?ref=add-secrets-modules"

  name     = "APM/TOKEN"
  secret   = var.token
}

module "apm_token_to" {
  source   = "github.com/TradrAPI/terraform-modules.git//aws/secrets?ref=add-secrets-modules"

  name           = "APM/TOKEN"
  secret         = var.token
  replica_region = "eu-west-2"
}

```

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
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | n/a | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of Secret | `string` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | Secret value | `string` | `" "` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_secret"></a> [secret](#output\_secret) | n/a |
<!-- END_TF_DOCS -->