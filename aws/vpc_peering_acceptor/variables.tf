variable "name" {
  type        = string
  description = "Peering connection name."
}

variable "peering_conn_id" {
  type        = string
  description = "Peering connection id."
}

variable "requester_cidr" {
  type        = string
  description = "Requester VPC cidr range."
  default     = null
}

variable "allow_remote_vpc_dns_resolution" {
  type        = bool
  default     = true
  description = "Defines whether DNS records that points to resources having a private ip on this vpc are resolved to the private ip instead of the public one."
}

variable "sg_id" {
  type        = string
  description = "Security group to associate with the rules defined via `sg_rules`."
  default     = null
}

variable "sg_rules" {
  type = any

  # list(object({
  #   type        = string
  #   from_port   = number
  #   to_port     = number
  #   protocol    = string
  #   description = string
  #   cidr_blocks = optional(list(string))
  # }))

  default = []

  description = "Rules applied to incoming requests from the peering requester VPC connection. Use this to add SG rules that apply to the SG with id `sg_id`. cidr_block applied is the one passed via `requester_cidr`."
}
