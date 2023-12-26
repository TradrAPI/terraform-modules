variable "subnet" {
  type        = list(string)
  description = "List of subnets ID For Redis subnet"
}

variable "name" {
  type        = string
  description = "Name of Redis Cluster"
}

variable "vpc" {
  type        = string
  description = "VPC ID"
}

variable "platform" {
  type        = string
  description = "Name of Platform or Brand"
}

variable "port" {
  type        = number
  description = "port number for redis"
}

variable "az_zones" {
  type        = list(string)
  description = "List of available Zones"
}
variable "engine_version" {
  type        = string
  description = "version number of redis"
}
variable "size" {
  type    = string
  default = "t2.small"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "security_group_id" {
  type        = string
  description = "The id of the general security group"
  default     = null
}

variable "cluster_mode" {
  type = object({
    replicas_per_node_group = number
    num_node_groups         = number
  })

  default  = null
  nullable = true
}

variable "multi_az_enabled" {
  type    = bool
  default = false
}

variable "parameter_group_name" {
  type     = string
  default  = null
  nullable = true
}

variable "log_delivery_configuration" {
  type = object({
    destination      = string
    destination_type = string
    log_format       = string
    log_type         = string
  })

  default = null
}
