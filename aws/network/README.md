# AWS Network

Created a VPC with a public and private subnet.

# Migrating to v3 from v2

First ensure you're using the latest v2 version of the module, like below

```hcl
module "network" {
  source = "github.com/TradrApi/terraform-modules//aws/network?ref=v2"
  # ...
}
```

Once the above is done, and you have applied the changes, add the following to your module call.

```hcl
module "network" {
  source = "github.com/TradrApi/terraform-modules//aws/network?ref=v3"
  # ...

  create_route_table_v2              = true
  associate_public_route_table_v2    = 3    # <- number of AZz in the region
  associate_private_route_table_v2   = 3    # <- number of AZz in the region
}
```

Apply the above, it'll create the route tables and associate them to the subnets. If you feel anything is missing, or not working properly, rollback and re-apply.

Note: you can progressively associate the subnets to the new route tables, by incrementing `associate_public_route_table_v2` and/or `associate_private_route_table_v2` (from `1` to `#number of AZs in the region`) and applying the changes step by step.

Once that's done we can remove the old route tables.

```hcl
module "network" {
  source = "github.com/TradrApi/terraform-modules//aws/network?ref=v3"
  # ...
  create_route_table_v2              = true
  associate_public_route_table_v2    = 3    # <- number of AZz in the region
  associate_private_route_table_v2   = 3    # <- number of AZz in the region
  remove_all_private_route_tables_v1 = true # <- remove all old private route tables
  remove_all_public_route_tables_v1  = true # <- remove all old public route tables
}
```

Once the above is applied, you can update the module to the latest version. Kindly note to remove the `create_route_table_v2` and `associate_public_route_table_v2` and `associate_private_route_table_v2` inputs.

```hcl
module "network" {
  source = "github.com/TradrApi/terraform-modules//aws/network?ref=v3"
  # ...
}
```

The above should only show `Name` tag updates. Once applied, you're done.

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
| [aws_cloudwatch_log_group.flowlogs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_policy.flowlog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.flowlog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.flow_log_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_internet_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_transit_gateway) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | The Autonomous System Number (ASN) for the Amazon side of the TGW. | `string` | `"64512"` | no |
| <a name="input_associate_private_route_table_v2"></a> [associate\_private\_route\_table\_v2](#input\_associate\_private\_route\_table\_v2) | n/a | `number` | `0` | no |
| <a name="input_associate_public_route_table_v2"></a> [associate\_public\_route\_table\_v2](#input\_associate\_public\_route\_table\_v2) | n/a | `number` | `0` | no |
| <a name="input_az_zones"></a> [az\_zones](#input\_az\_zones) | List of available Zones | `list(string)` | <pre>[<br/>  "us-west-1a",<br/>  "us-west-1b"<br/>]</pre> | no |
| <a name="input_create_route_table_v2"></a> [create\_route\_table\_v2](#input\_create\_route\_table\_v2) | n/a | `bool` | `false` | no |
| <a name="input_deployment_env"></a> [deployment\_env](#input\_deployment\_env) | Environment where the VPC resides | `string` | n/a | yes |
| <a name="input_enable_tgw_routes_in_public_subnets"></a> [enable\_tgw\_routes\_in\_public\_subnets](#input\_enable\_tgw\_routes\_in\_public\_subnets) | n/a | `bool` | `false` | no |
| <a name="input_extra_private_routes"></a> [extra\_private\_routes](#input\_extra\_private\_routes) | List of route configs, see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table#route-argument-reference | <pre>list(object({<br/>    cidr_block                = string<br/>    vpc_peering_connection_id = optional(string)<br/>    network_interface_id      = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_extra_private_routes_per_az"></a> [extra\_private\_routes\_per\_az](#input\_extra\_private\_routes\_per\_az) | n/a | <pre>map(list(object({<br/>    cidr_block                = string<br/>    vpc_peering_connection_id = optional(string)<br/>    network_interface_id      = optional(string)<br/>  })))</pre> | `{}` | no |
| <a name="input_extra_public_routes"></a> [extra\_public\_routes](#input\_extra\_public\_routes) | List of route configs, see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table#route-argument-reference | <pre>list(object({<br/>    cidr_block                = string<br/>    vpc_peering_connection_id = optional(string)<br/>    network_interface_id      = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_flowlogs"></a> [flowlogs](#input\_flowlogs) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | name of vpc | `string` | n/a | yes |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_private_subnets_cidrs"></a> [private\_subnets\_cidrs](#input\_private\_subnets\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_public_subnets_cidrs"></a> [public\_subnets\_cidrs](#input\_public\_subnets\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | region of VPC | `string` | n/a | yes |
| <a name="input_remove_all_private_route_tables_v1"></a> [remove\_all\_private\_route\_tables\_v1](#input\_remove\_all\_private\_route\_tables\_v1) | n/a | `bool` | `false` | no |
| <a name="input_remove_all_public_route_tables_v1"></a> [remove\_all\_public\_route\_tables\_v1](#input\_remove\_all\_public\_route\_tables\_v1) | n/a | `bool` | `false` | no |
| <a name="input_tgw_cidrs"></a> [tgw\_cidrs](#input\_tgw\_cidrs) | CIDRs to be routed through the TGW | `list(string)` | `[]` | no |
| <a name="input_tgw_subnet_tags"></a> [tgw\_subnet\_tags](#input\_tgw\_subnet\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_tgw_subnets_cidrs"></a> [tgw\_subnets\_cidrs](#input\_tgw\_subnets\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | `null` | no |
| <a name="input_vpc_sub"></a> [vpc\_sub](#input\_vpc\_sub) | first two octets of subnet vpc | `string` | `"10.0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat_gateways"></a> [nat\_gateways](#output\_nat\_gateways) | List of nat gateways |
| <a name="output_private_route_tables"></a> [private\_route\_tables](#output\_private\_route\_tables) | List of private route tables |
| <a name="output_private_routes"></a> [private\_routes](#output\_private\_routes) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of private subnets |
| <a name="output_public_route_tables"></a> [public\_route\_tables](#output\_public\_route\_tables) | List of public route tables |
| <a name="output_public_routes"></a> [public\_routes](#output\_public\_routes) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of public subnets |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | The ID of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->
