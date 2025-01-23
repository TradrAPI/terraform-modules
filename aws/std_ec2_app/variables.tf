variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "name" {
  type = string
}

variable "resources_prefix" {
  type = string
}

variable "az" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "root_volume_size" {
  type = number
}

variable "data_volume_size" {
  type    = number
  default = null
}

variable "data_volume_tags" {
  type = map(string)

  default = {}
}

variable "ansible_group" {
  type = string
}

variable "authorized_key" {
  type = string
}

variable "swap_size" {
  type = number

  default = 2
}

variable "user_data_obj" {
  type = any

  default = {}
}

variable "security_group_ids" {
  type = list(string)

  default = []
}

variable "http_trusted_cidrs" {
  type = list(string)

  default = ["0.0.0.0/0"]
}

variable "ssh_trusted_cidrs" {
  type = list(string)

  default = ["0.0.0.0/0"]
}

variable "attach_eip" {
  type = bool

  default = false
}

variable "associate_public_ip" {
  type = bool

  default = false
}

variable "tags" {
  type = map(string)

  default = {}
}

variable "ssh_port" {
  type = number

  default = 22
}

variable "private_ip" {
  type = string

  default = null
}

variable "certbot" {
  type = object({
    fqdn                 = string
    cloudflare_api_token = string
    notification_email   = string
    test                 = bool
  })

  default = null
}

variable "ami_filter" {
  type = object({
    owner = string
    name  = string
  })

  default = {
    owner = "099720109477"
    name  =  "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  }
}