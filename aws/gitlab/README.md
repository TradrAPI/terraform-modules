# APPLICATIONS/GITLAB

Spins up infrastructure to support a GitLab standalone instance.

[[_TOC_]]

## Important notes
- !!! When using this module with nitro based instances, you'll need to perform some manual steps after the instance first boot up (**TRY USING THE APPLICATIONS/STD_EC2_APP MODULE INSTEAD**). If the disk is already mounted with both label and filesystem, you may ignore these steps
```console
$ sudo fdisk -l                                                 # First, get the name of the NVMe disk device via, it must be something like /dev/nvme1n1
$ sudo mv /mnt/gitlab-data /mnt/gitlab-data-bkp                 # Backup the current folder, at first boot time only cert will be there
$ sudo mkfs.ext4 -L gitlab-data <device-name-of-the-first-step> # Manually create the file system on the device and label it (labelling will prevent relying on device name on future boots)
$ sudo mount -a                                                 # Mount point is already on /etc/fstab referencing the label
$ sudo mv /mnt/gitlab-data-bkp/* /mnt/gitlab-data/              # Move the data back to the used folder, this time using the intended disk
```
- Ensure you use some proper tags to target the created instance via ansible, like shown on the example section.

## Required variables

- `resources_prefix` - SGs and DLM will be created with this prefix on their name
- `type` - EC2 instance type.
  - See https://aws.amazon.com/ec2/instance-types/
  - Also keep in mind the GitLab hardware requirements https://docs.gitlab.com/ee/install/requirements.html#hardware-requirements
- `cloudflare_certbot_token` - CloudFlare API token
  - Be granular on the token permissions, so grant only `Zone:DNS:Edit` access to the token based on the needed zone
  - Also see https://certbot-dns-cloudflare.readthedocs.io/en/stable/#credentials
- `certbot_notification_email` - Certificate expiration emails goes to this address
- `gitlab_fqdn` - GitLab instance DNS name. Be aware that the domain must match the zone which the `cloudflare_certbot_token` has access to.
- `vpc_id` - VPC where to create the instance associated SGs
- `az_zone` -  Availability Zone to create the instance and EBS volume into
- `admin_authorized_key` - devops-admin user public key. Ensure you share the private key under LastPass Shared-DevOps folder

## Optional variables

- `name` - Instance name
- `instance_ssh_trusted_cidrs` - list of SSH allowed cidrs to access the GitLab instance (By instance here I mean the EC2 VM on AWS)
- `instance_ssh_port` - SSH port used for connecting to the instance running GitLab
- `gitlab_ssh_trusted_cidrs` - list of GitLab SSH allowed cidrs, this refers to cidrs able to pull/push and do git operations through git ssh connections
- `http_trusted_cidrs` - list of HTTP and HTTPS allowed cidrs
- `swap_size` - in GiB
- `tags` - map of tag name to tag value
- `ssh_port` - instance SSH port, be aware that port 22 is reserved to the GitLab container (once provisioned)
- `use_test_cert` - Wether to spin up a staging Certbot certificate during instance first boot. Use this to prevent you from getting rate limit issues.
  - See https://letsencrypt.org/docs/rate-limits/
- `subnet_id` - Subnet to put the instance into
- `root_volume_size` - in GiB
- `data_volume_size` - in GiB
- `data_volume_tags` - tags to attach to the ebs volume
- `security_groups_ids` - List of extra security groups to put the instance into
- `private_ip` - instance's private ip

## Scope of this module

`module.iam`

`aws_dlm_lifecycle_policy`

`module.gitlab`

## Examples

```terraform
locals {
  az_zone = "${data.aws_region.this.name}a"
}

module "gitlab" {
  source = "module-source"

  cloudflare_certbot_token = var.cloudflare_certbot_token
  vpc_id                   = data.aws_vpc.default.id
  az_zone                  = local.az_zone

  type             = "t2.large"
  name             = "dev-gitlab"
  resources_prefix = "dev"

  http_trusted_cidrs         = ["0.0.0.0/0"]
  gitlab_ssh_trusted_cidrs   = ["0.0.0.0/0"]
  instance_ssh_trusted_cidrs = ["0.0.0.0/0"]
  instance_ssh_port          = 2224

  gitlab_fqdn                = "gitlab.mydomain.com"
  certbot_notification_email = "devops@myemail.com"
  use_test_cert              = true

  tags = {
    AnsibleManaged = "yes"
    AnsibleGroup   = "gitlab"
  }

  admin_authorized_key = file("./files/dev-gitlab-devops-admin.pub")

  swap_size        = 2
  root_volume_size = 20
  data_volume_size = 100
}
```

## Outputs

- `eip` - Instance's elastic ip
- `instance` - Same as https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attributes-reference
- `sg` - Same as https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group#attributes-reference
- `dlm` - Same as https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dlm_lifecycle_policy#attributes-reference
- `iam`

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
| <a name="module_bucket"></a> [bucket](#module\_bucket) | ../s3 | n/a |
| <a name="module_gitlab"></a> [gitlab](#module\_gitlab) | ../ec2 | n/a |
| <a name="module_secrets_bucket"></a> [secrets\_bucket](#module\_secrets\_bucket) | ../s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_iam_instance_profile.bucket_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.bucket_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.bucket_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.bucket_iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group_rule.gitlab_ssh_port_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_volume_attachment.extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_authorized_key"></a> [admin\_authorized\_key](#input\_admin\_authorized\_key) | n/a | `string` | n/a | yes |
| <a name="input_az_zone"></a> [az\_zone](#input\_az\_zone) | n/a | `string` | n/a | yes |
| <a name="input_backup_agent"></a> [backup\_agent](#input\_backup\_agent) | n/a | <pre>object({<br/>    bucket = object({<br/>      name          = string<br/>      lifetime_days = optional(number, 8)<br/>    })<br/><br/>    iam = optional(object({<br/>      policy           = optional(string, "GitlabS3BackupReadWritePolicy")<br/>      role             = optional(string, "GitlabS3BackupAgent")<br/>      instance_profile = optional(string, "Gitlabs3BackupAgent")<br/>    }), {})<br/>  })</pre> | <pre>{<br/>  "bucket": {<br/>    "lifetime_days": 8,<br/>    "name": "prd-gitlab-backups"<br/>  },<br/>  "iam": {<br/>    "instance_profile": "Gitlabs3BackupAgent",<br/>    "policy": "GitlabS3BackupReadWritePolicy",<br/>    "role": "GitlabS3BackupAgent"<br/>  }<br/>}</pre> | no |
| <a name="input_certbot_notification_email"></a> [certbot\_notification\_email](#input\_certbot\_notification\_email) | n/a | `string` | n/a | yes |
| <a name="input_cloudflare_certbot_token"></a> [cloudflare\_certbot\_token](#input\_cloudflare\_certbot\_token) | n/a | `string` | n/a | yes |
| <a name="input_data_volume_size"></a> [data\_volume\_size](#input\_data\_volume\_size) | n/a | `number` | `80` | no |
| <a name="input_data_volume_tags"></a> [data\_volume\_tags](#input\_data\_volume\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_extra_volumes"></a> [extra\_volumes](#input\_extra\_volumes) | n/a | <pre>map(object({<br/>    device_name = string<br/>    size        = number<br/>    tags        = map(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_gitlab_fqdn"></a> [gitlab\_fqdn](#input\_gitlab\_fqdn) | n/a | `string` | n/a | yes |
| <a name="input_gitlab_ssh_trusted_cidrs"></a> [gitlab\_ssh\_trusted\_cidrs](#input\_gitlab\_ssh\_trusted\_cidrs) | n/a | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_http_trusted_cidrs"></a> [http\_trusted\_cidrs](#input\_http\_trusted\_cidrs) | n/a | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_instance_ssh_port"></a> [instance\_ssh\_port](#input\_instance\_ssh\_port) | n/a | `number` | `2224` | no |
| <a name="input_instance_ssh_trusted_cidrs"></a> [instance\_ssh\_trusted\_cidrs](#input\_instance\_ssh\_trusted\_cidrs) | n/a | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | `"gitlab"` | no |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | n/a | `string` | `null` | no |
| <a name="input_resources_prefix"></a> [resources\_prefix](#input\_resources\_prefix) | n/a | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | n/a | `number` | `20` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | `null` | no |
| <a name="input_swap_size"></a> [swap\_size](#input\_swap\_size) | n/a | `number` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_type"></a> [type](#input\_type) | n/a | `string` | n/a | yes |
| <a name="input_use_test_cert"></a> [use\_test\_cert](#input\_use\_test\_cert) | n/a | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eip"></a> [eip](#output\_eip) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_sg"></a> [sg](#output\_sg) | n/a |
<!-- END_TF_DOCS -->