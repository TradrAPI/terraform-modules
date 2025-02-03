# GENERIC/EC2_INSTANCE module

Used to provision a simple ec2 instance

## Required variables

- `name` - instance name
- `key_pair` -  object containing key `name` and `public_key` of a `key_pair` used to access the instance
- `resources_prefix` - prefix used on module created resources
- `vpc_id` - vpc to create the instance into

## Optional variables

- `os_type` - defaults to `linux`. Choosing `windows` changes the hanling of the `user_data` input var
- `win_admin_user` - windows instance admin user
  - `name`
  - `password`
- `ebs` - object specifying a volume to attach to the instance:
  - `size`
  - `device_name`
  - `az`
  - `type`
  - `tags`
- `ami_filter` - object specifying a filter in order to search for a ami to create the instance from. Takes precedence over `ami_id`
  - `name` - name pattern to search
  - `owner` - search for name patter on this owner
- `ami_id` - base the instance creation on this ami
- `type` - EBS volume type
- `associate_public_ip_address` - Whether to associate a public address to the created instance. The instance must be on a public network
- `subnet_id` - Creates the instance on this subnet
- `user_data` - user data script to run at the instance first boot. Either Shell or Powershell (if `os_type = "windows"`).
- `tags` - instance tags
- `ssh_trusted_cidrs` - list of cidr range blocks able to connect to the ssh port 22
- `http_trusted_cidrs` - list of cidr range blocks able to send http requests to the instance
- `http_port` - http traffic port
- `allow_https` - enable https inbound traffic
- `attach_eip` - create and attach an eip to the instance
- `availability_zone` - AZ to boot the instance in. Must match `ebs.az`. Matching by subnet az is also possible.
- `root_volume_size` - size in GiB
- `root_volume_type` - one of standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to gp2
- `security_groups_ids` - List of extra security groups to put the instance into
- `private_ip` - instance's private ip
- `user_data_obj` - Same as `user_data` ([`cloud-init` format](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)) but as a terraform object. All attributes are allowed. `user_data` takes priority if for some reason both are provided.

## Scope of this module

`aws_ebs_volume`

`aws_key_pair`

`aws_instance`

`aws_volume_attachment`

`aws_security_group`

`aws_security_group_rule`

## Examples

```terraform
data "aws_vpc" "default" {
  default = true
}

module "instance" {
  source = "../.."

  vpc_id = data.aws_vpc.default.id

  resources_prefix   = "test-instance"
  ssh_trusted_cidrs  = ["0.0.0.0/0"]
  http_trusted_cidrs = ["0.0.0.0/0"]

  name                        = "test-instance"
  type                        = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Environment = "Testing"
  }

  key_pair = {
    name       = "test-instance"
    public_key = file("files/testkey.pub")
  }

  ami_filter = {
    owner = "amazon"
    name  = "amzn2-ami-hvm-2.0.20211001.1-x86_64-gp2"
  }
}
```

## Outputs

`this` - Created instance attributes as described on https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference

`ebs` - Created ebs volumme attributes as described on https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume#attributes-reference

`sg` - instance security group attributes as described on https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#attributes-reference

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
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
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
| <a name="input_allow_https"></a> [allow\_https](#input\_allow\_https) | n/a | `bool` | `false` | no |
| <a name="input_ami_filter"></a> [ami\_filter](#input\_ami\_filter) | n/a | <pre>object({<br/>    owner = string<br/>    name  = string<br/>  })</pre> | `null` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | n/a | `string` | `null` | no |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | n/a | `bool` | `false` | no |
| <a name="input_attach_eip"></a> [attach\_eip](#input\_attach\_eip) | n/a | `bool` | `false` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | n/a | `string` | `null` | no |
| <a name="input_disable_api_termination"></a> [disable\_api\_termination](#input\_disable\_api\_termination) | n/a | `bool` | `false` | no |
| <a name="input_ebs"></a> [ebs](#input\_ebs) | n/a | <pre>object({<br/>    size        = number<br/>    device_name = optional(string, "xvdf")<br/>    az          = optional(string)<br/>    type        = optional(string)<br/>    iops        = optional(string)<br/>    tagName     = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_get_password_data"></a> [get\_password\_data](#input\_get\_password\_data) | n/a | `bool` | `false` | no |
| <a name="input_http_port"></a> [http\_port](#input\_http\_port) | n/a | `number` | `80` | no |
| <a name="input_http_trusted_cidrs"></a> [http\_trusted\_cidrs](#input\_http\_trusted\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | n/a | `string` | `null` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | n/a | `number` | `null` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | n/a | <pre>object({<br/>    name       = string<br/>    public_key = string<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | n/a | `string` | `"linux"` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | n/a | `string` | `null` | no |
| <a name="input_resources_prefix"></a> [resources\_prefix](#input\_resources\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | n/a | `number` | `8` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | n/a | `string` | `"gp3"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_sg_description"></a> [sg\_description](#input\_sg\_description) | n/a | `string` | `""` | no |
| <a name="input_ssh_port"></a> [ssh\_port](#input\_ssh\_port) | n/a | `number` | `22` | no |
| <a name="input_ssh_trusted_cidrs"></a> [ssh\_trusted\_cidrs](#input\_ssh\_trusted\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | `"t2.micro"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | `string` | `null` | no |
| <a name="input_user_data_obj"></a> [user\_data\_obj](#input\_user\_data\_obj) | n/a | `any` | `null` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |
| <a name="input_win_admin_user"></a> [win\_admin\_user](#input\_win\_admin\_user) | n/a | <pre>object({<br/>    name     = string<br/>    password = string<br/>  })</pre> | <pre>{<br/>  "name": "",<br/>  "password": ""<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ebs"></a> [ebs](#output\_ebs) | n/a |
| <a name="output_eip"></a> [eip](#output\_eip) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_sg"></a> [sg](#output\_sg) | n/a |
| <a name="output_this"></a> [this](#output\_this) | n/a |
<!-- END_TF_DOCS -->