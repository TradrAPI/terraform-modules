variable "vpc_id" {
  type = string
}

variable "peer_vpcs" {
  type = map(object({
    peer_owner_id                   = string
    peer_vpc_id                     = string
    peer_region                     = string
    peer_cidr                       = string
    tags                            = map(string)
    allow_remote_vpc_dns_resolution = bool
  }))
}
