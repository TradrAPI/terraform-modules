variable "policies" {
  type = any

  # structure:
  #
  # object({
  #   file        = optional(string)
  #   content     = optional(string)
  #   content_obj = optional(object)
  #   description = optional(string)
  #   path        = optional(string)
  #   tags        = optional(map(string))
  # })

  default = {}
}

variable "groups" {
  type    = map(list(string))
  default = {}
}

variable "roles" {
  type = any

  # map(object({
  #   assume_role_policy = dynamically defined
  #   policies           = list(string)
  #   tags               = map(string)
  # }))

  default = {}
}

variable "skip_group_creation" {
  type    = bool
  default = false
}
