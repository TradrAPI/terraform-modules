## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_peering_connection_accepter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [aws_vpc_peering_connection_options.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_options) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_remote_vpc_dns_resolution"></a> [allow\_remote\_vpc\_dns\_resolution](#input\_allow\_remote\_vpc\_dns\_resolution) | Defines whether DNS records that points to resources having a private ip on this vpc are resolved to the private ip instead of the public one. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Peering connection name. | `string` | n/a | yes |
| <a name="input_peering_conn_id"></a> [peering\_conn\_id](#input\_peering\_conn\_id) | Peering connection id. | `string` | n/a | yes |
| <a name="input_requester_cidr"></a> [requester\_cidr](#input\_requester\_cidr) | Requester VPC cidr range. | `string` | n/a | yes |
| <a name="input_sg_id"></a> [sg\_id](#input\_sg\_id) | Security group to associate with the rules defined via `sg_rules`. | `string` | n/a | yes |
| <a name="input_sg_rules"></a> [sg\_rules](#input\_sg\_rules) | Rules applied to incoming requests from the peering requester VPC connection. Use this to add SG rules that apply to the SG with id `sg_id`. cidr\_block applied is the one passed via `requester_cidr`. | <pre>list(object({<br>    type        = string<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    description = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_routes_back_to_requester_vpc"></a> [routes\_back\_to\_requester\_vpc](#output\_routes\_back\_to\_requester\_vpc) | Pass this as `extra_public_routes` and `extra_private_routes` input vars on the NETWORK module usage on the requester VPC code. |
<!-- END_TF_DOCS -->