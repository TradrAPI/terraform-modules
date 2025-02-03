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
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_vpc_peering_connection_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_peer_vpcs"></a> [peer\_vpcs](#input\_peer\_vpcs) | n/a | <pre>map(object({<br/>    peer_owner_id                   = string<br/>    peer_vpc_id                     = string<br/>    peer_region                     = string<br/>    peer_cidr                       = string<br/>    tags                            = map(string)<br/>    allow_remote_vpc_dns_resolution = bool<br/>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peer_connections"></a> [peer\_connections](#output\_peer\_connections) | n/a |
| <a name="output_routes_to_accepter_vpcs"></a> [routes\_to\_accepter\_vpcs](#output\_routes\_to\_accepter\_vpcs) | n/a |
<!-- END_TF_DOCS -->