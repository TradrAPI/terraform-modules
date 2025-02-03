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
| [aws_ebs_volume.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress_all_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.http_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.https_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_volume_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_filter"></a> [ami\_filter](#input\_ami\_filter) | n/a | <pre>object({<br/>    owner = string<br/>    name  = string<br/>  })</pre> | <pre>{<br/>  "name": "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*",<br/>  "owner": "099720109477"<br/>}</pre> | no |
| <a name="input_ansible_group"></a> [ansible\_group](#input\_ansible\_group) | n/a | `string` | n/a | yes |
| <a name="input_associate_public_ip"></a> [associate\_public\_ip](#input\_associate\_public\_ip) | n/a | `bool` | `false` | no |
| <a name="input_attach_eip"></a> [attach\_eip](#input\_attach\_eip) | n/a | `bool` | `false` | no |
| <a name="input_authorized_key"></a> [authorized\_key](#input\_authorized\_key) | n/a | `string` | n/a | yes |
| <a name="input_az"></a> [az](#input\_az) | n/a | `string` | n/a | yes |
| <a name="input_certbot"></a> [certbot](#input\_certbot) | n/a | <pre>object({<br/>    fqdn                 = string<br/>    cloudflare_api_token = string<br/>    notification_email   = string<br/>    test                 = bool<br/>  })</pre> | `null` | no |
| <a name="input_data_volume_size"></a> [data\_volume\_size](#input\_data\_volume\_size) | n/a | `number` | `null` | no |
| <a name="input_data_volume_tags"></a> [data\_volume\_tags](#input\_data\_volume\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_http_trusted_cidrs"></a> [http\_trusted\_cidrs](#input\_http\_trusted\_cidrs) | n/a | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | n/a | `string` | `null` | no |
| <a name="input_resources_prefix"></a> [resources\_prefix](#input\_resources\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | n/a | `number` | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | n/a | `number` | `22` | no |
| <a name="input_ssh_trusted_cidrs"></a> [ssh\_trusted\_cidrs](#input\_ssh\_trusted\_cidrs) | n/a | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | n/a | `number` | `2` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_user_data_obj"></a> [user\_data\_obj](#input\_user\_data\_obj) | n/a | `any` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ebs"></a> [ebs](#output\_ebs) | n/a |
| <a name="output_eip"></a> [eip](#output\_eip) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_sg"></a> [sg](#output\_sg) | n/a |
<!-- END_TF_DOCS -->