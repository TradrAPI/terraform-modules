variable "bucket_id" {
  type = string
}

variable "policy" {
  type = string
}

variable "group" {
  type = string
}

variable "role" {
  type    = string
  default = null
}

variable "user" {
  type = string
}
