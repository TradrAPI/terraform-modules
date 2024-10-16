variable "name" {
  type = string
}

variable "resources_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "key_pair" {
  type = object({
    name       = string
    public_key = string
  })

  default = null
}

variable "ebs" {
  type = object({
    size        = number
    device_name = string
    az          = string
    type        = string
    tags        = map(string)
  })

  default = null
}

variable "ami_filter" {
  type = object({
    owner = string
    name  = string
  })

  default = null
}

variable "ami_id" {
  type    = string
  default = null
}

variable "type" {
  type    = string
  default = "t2.micro"
}

variable "associate_public_ip_address" {
  type    = bool
  default = false
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "user_data" {
  type    = string
  default = null
}

variable "user_data_obj" {
  type    = any
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ssh_trusted_cidrs" {
  type = list(string)

  default = []
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "http_trusted_cidrs" {
  type = list(string)

  default = []
}

variable "http_port" {
  type    = number
  default = 80
}

variable "attach_eip" {
  type    = bool
  default = false
}

variable "allow_https" {
  type    = bool
  default = false
}

variable "availability_zone" {
  type    = string
  default = null
}

variable "root_volume_size" {
  type    = number
  default = 8
}

variable "root_volume_type" {
  type    = string
  default = "gp2"
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "private_ip" {
  type    = string
  default = null
}

variable "get_password_data" {
  type    = bool
  default = false
}

variable "disable_api_termination" {
  type    = bool
  default = false
}

variable "os_type" {
  type    = string
  default = "linux"
}

variable "win_admin_user" {
  type = object({
    name     = string
    password = string
  })

  default = {
    name     = ""
    password = ""
  }
}

variable "iam_instance_profile" {
  type     = string
  default  = null
  nullable = true
}

variable "sg_description" {
  type    = string
  default = ""
}
