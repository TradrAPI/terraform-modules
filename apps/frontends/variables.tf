variable "environment" {
  type = string
}

variable "bucket_force_destroy" {
  type    = bool
  default = false
}

variable "account_id" {
  type = string
}

variable "domains" {
  type = list(string)
}

variable "partitions" {
  type = map(map(string))
}

variable "create_bucket" {
  type    = bool
  default = true
}

variable "allowed_source_ips" {
  type    = list(string)
  default = []
}

variable "allow_record_overwrite" {
  type    = bool
  default = false
}

variable "create_artifact_bucket" {
  type    = bool
  default = false
}
