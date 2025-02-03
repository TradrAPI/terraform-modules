<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.18 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.18 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_accepter"></a> [accepter](#module\_accepter) | ../.. | n/a |
| <a name="module_accepter_instance"></a> [accepter\_instance](#module\_accepter\_instance) | ../.. | n/a |
| <a name="module_accepter_network"></a> [accepter\_network](#module\_accepter\_network) | ../.. | n/a |
| <a name="module_requester"></a> [requester](#module\_requester) | ../.. | n/a |
| <a name="module_requester_instance"></a> [requester\_instance](#module\_requester\_instance) | ../.. | n/a |
| <a name="module_requester_network"></a> [requester\_network](#module\_requester\_network) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accepter_private_ip"></a> [accepter\_private\_ip](#output\_accepter\_private\_ip) | n/a |
| <a name="output_connect_accepter"></a> [connect\_accepter](#output\_connect\_accepter) | n/a |
| <a name="output_connect_requester"></a> [connect\_requester](#output\_connect\_requester) | n/a |
| <a name="output_requester_private_ip"></a> [requester\_private\_ip](#output\_requester\_private\_ip) | n/a |
<!-- END_TF_DOCS -->