
variable "region" {
  type        = string
  description = "region of VPC"
}

variable "name" {
  type        = string
  description = "name of vpc"
}

variable "vpc_sub" {
  type        = string
  default     = "10.0"
  description = "first two octets of subnet vpc"
}

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "tgw_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "az_zones" {
  type        = list(string)
  description = "List of available Zones"
  default     = ["us-west-1a", "us-west-1b"]
}

variable "deployment_env" {
  type        = string
  description = "Environment where the VPC resides"
}

# Only vpc peering supported for now
variable "extra_public_routes" {
  type = list(object({
    cidr_block                = string
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))

  default     = []
  description = "List of route configs, see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table#route-argument-reference"
}

# Only vpc peering supported for now
variable "extra_private_routes" {
  type = list(object({
    cidr_block                = string
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  }))

  default     = []
  description = "List of route configs, see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table#route-argument-reference"
}

variable "extra_private_routes_per_az" {
  type = map(list(object({
    cidr_block                = string
    vpc_peering_connection_id = optional(string)
    network_interface_id      = optional(string)
  })))

  default = {}
}

variable "enable_tgw_routes_in_public_subnets" {
  type    = bool
  default = false
}

variable "tgw_cidrs" {
  type        = list(string)
  description = "CIDRs to be routed through the TGW"

  default = []
}

variable "amazon_side_asn" {
  type        = string
  description = "The Autonomous System Number (ASN) for the Amazon side of the TGW."

  default = "64512"
}

variable "create_route_table_v2" {
  type    = bool
  default = false
}

variable "associate_public_route_table_v2" {
  type    = number
  default = 0
}

variable "associate_private_route_table_v2" {
  type    = number
  default = 0
}

variable "remove_all_public_route_tables_v1" {
  type    = bool
  default = false
}

variable "remove_all_private_route_tables_v1" {
  type    = bool
  default = false
}


variable "vpc_cidr" {
  type     = string
  default  = null
  nullable = true
}

variable "public_subnets_cidrs" {
  type    = list(string)
  default = []
}

variable "private_subnets_cidrs" {
  type    = list(string)
  default = []
}

variable "tgw_subnets_cidrs" {
  type    = list(string)
  default = []
}
