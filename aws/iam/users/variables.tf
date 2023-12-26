variable "users" {
  type = map(object({
    groups                 = optional(list(string), [])
    tags                   = optional(map(string), {})
    policy                 = optional(string)
    attached_policies_arns = optional(list(string), [])
  }))
}
