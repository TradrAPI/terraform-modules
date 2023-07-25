variable "mongodb_projectid" {
  type        = string
  description = "The mongodb project id, which can be found in project settings"
}

variable "mongodb_permissions" {
  type = list(object({
    dbname = string
    role = string
  }))
}

variable "mongodb_clusters" {
  type = list(string)
  default = []
}

variable "platform" {
  type = string
}

variable "name_suffix" {
  type    = string
  default = "-user"
}

variable "external_password" {
  type      = string
  default   = null
  sensitive = true
}

variable "external_username" {
  type    = string
  default = null
}

variable "brandname" {
  type = string
  default = ""
}

variable create_outputs {
  type = bool
  default = false
  description = "only set to true if there is at least 1 item in mongodb_clusters and 1 item in mongodb_permissions. It will always use the values in the first item"
}

variable connection_string_shards {
  type = bool
  default = true
  description = "define whether to use the connection string with the shards or not, see here for more information https://www.mongodb.com/docs/manual/reference/connection-string/"
}

variable encryption_key {
  type = string
  default = null
}
