variable "databases" {
  type    = list(string)
  default = []
}

variable "owner" {
  type    = string
  default = ""
}

variable "roles" {
  type = map(object({
    target_dbs = list(string)
    login      = bool
    privileges = object({
      table    = list(string)
      schema   = list(string)
      sequence = list(string)
    })
  }))
}
