variable "resources_prefix" {
  type = string
}

variable "type" {
  type = string
}

variable "cloudflare_certbot_token" {
  type      = string
  sensitive = true
}

variable "certbot_notification_email" {
  type = string
}

variable "gitlab_fqdn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "az_zone" {
  type = string
}

variable "admin_authorized_key" {
  type = string
}

variable "name" {
  type    = string
  default = "gitlab"
}

variable "instance_ssh_trusted_cidrs" {
  type = list(string)

  default = ["0.0.0.0/0"]
}

variable "gitlab_ssh_trusted_cidrs" {
  type = list(string)

  default = ["0.0.0.0/0"]
}

variable "http_trusted_cidrs" {
  type = list(string)

  default = ["0.0.0.0/0"]
}

variable "swap_size" {
  type    = number
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "instance_ssh_port" {
  type    = number
  default = 2224
}

variable "use_test_cert" {
  type    = bool
  default = false
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "root_volume_size" {
  type    = number
  default = 20
}

variable "data_volume_size" {
  type    = number
  default = 80
}

variable "data_volume_tags" {
  type    = map(string)
  default = {}
}

variable "extra_volumes" {
  type = map(object({
    device_name = string
    size        = number
    tags        = map(string)
  }))
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "private_ip" {
  type    = string
  default = null
}

variable "backup_agent" {
  type = object({
    bucket = object({
      name          = string
      lifetime_days = optional(number, 8)
    })

    iam = optional(object({
      policy           = optional(string, "GitlabS3BackupReadWritePolicy")
      role             = optional(string, "GitlabS3BackupAgent")
      instance_profile = optional(string, "Gitlabs3BackupAgent")
    }), {})
  })

  default = {
    bucket = {
      name          = "prd-gitlab-backups"
      lifetime_days = 8
    }

    iam = {
      policy           = "GitlabS3BackupReadWritePolicy"
      role             = "GitlabS3BackupAgent"
      instance_profile = "Gitlabs3BackupAgent"
    }
  }
}
