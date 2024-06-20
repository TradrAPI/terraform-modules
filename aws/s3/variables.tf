variable "bucket_name" {
  type = string
}

variable "lifetime_days" {
  type        = number
  description = "The lifetime of the contents of the bucket before they expire, expressed in days"
  default     = -1
}

variable "force_destroy" {
  type    = bool
  default = false
}

variable "block_public_access" {
  type    = bool
  default = true
}

variable "bucket_policy" {
  type    = any
  default = null
}

variable "cors_rule" {
  type    = any
  default = null
}

variable "create_bucket_acl" {
  type    = bool
  default = true
}
