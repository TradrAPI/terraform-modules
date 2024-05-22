variable "name" {
  type = string
}

variable "create_user" {
  type    = bool
  default = true
}

variable "extra_permissions" {
  type    = list(string)
  default = []
}

variable "default_permissions" {
  type = list(string)

  default = ["kms:Encrypt", "kms:Decrypt"]

  validation {
    error_message = "The default_permissions variable can be at most 2 elements long and contain only kms:Encrypt or kms:Decrypt values."

    condition = (
      length(distinct(var.default_permissions)) <= 2
      && alltrue([
        for action in var.default_permissions : 
        contains(["kms:Encrypt", "kms:Decrypt"], action)
      ])
    )
  }
}
