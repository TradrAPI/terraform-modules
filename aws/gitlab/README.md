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
