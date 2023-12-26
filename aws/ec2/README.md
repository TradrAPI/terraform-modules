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
