variable "secret" {
  type        = string
  description = "Secret value"
  default     = " "
}
variable "platform" {
  type        = string
  description = "Platform of secret"
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
