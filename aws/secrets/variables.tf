variable "secret" {
  type        = string
  description = "Secret value"
  default     = " "
}


variable "name" {
  type        = string
  description = "Name of Secret"
}

variable "kms_key_id" {
  type     = string
  default  = null
  nullable = true
}

variable "replica" {
  type        = block({
    region = string
    kms_key_id = string
  })
  description = "Configuration block to support secret replication"
  default     = null
  nullable = true
}