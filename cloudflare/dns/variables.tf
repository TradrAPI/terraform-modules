variable "defaults" {
  description = "Default values for DNS records. These will be used if not specified in the records."

  type = object({
    value   = optional(string)
    type    = optional(string)
    proxied = optional(bool, false)
  })

  default = {}
}

variable "records_by_zone" {
  description = "Map of DNS records by zone. Each key is a zone name and the value is a list of records for that zone."

  type = map(list(object({
    name    = string
    value   = optional(string)
    type    = optional(string)
    proxied = optional(bool, false)
    id      = optional(string, "")
  })))

  default = {}
}
