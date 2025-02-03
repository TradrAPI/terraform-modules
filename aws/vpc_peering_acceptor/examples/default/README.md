<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_accepter"></a> [accepter](#module\_accepter) | ../.. | n/a |
| <a name="module_accepter_instance"></a> [accepter\_instance](#module\_accepter\_instance) | ../.. | n/a |
| <a name="module_accepter_network"></a> [accepter\_network](#module\_accepter\_network) | ../.. | n/a |
| <a name="module_requester_instance"></a> [requester\_instance](#module\_requester\_instance) | ../.. | n/a |
| <a name="module_requester_network"></a> [requester\_network](#module\_requester\_network) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group_rule.allow_peer_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_peering_connection.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_options.requester](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_set_req_options"></a> [set\_req\_options](#input\_set\_req\_options) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accepter_private_ip"></a> [accepter\_private\_ip](#output\_accepter\_private\_ip) | n/a |
| <a name="output_connect_accepter"></a> [connect\_accepter](#output\_connect\_accepter) | n/a |
| <a name="output_connect_requester"></a> [connect\_requester](#output\_connect\_requester) | n/a |
| <a name="output_requester_private_ip"></a> [requester\_private\_ip](#output\_requester\_private\_ip) | n/a |
<!-- END_TF_DOCS -->