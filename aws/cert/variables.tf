variable "domain" {
  type        = string
  description = "The Domain Record"
}

variable "subdomain" {
  type        = string
  description = "Optional Subdomain"
  default     = null
}

variable "deployment_env" {
  type        = string
  description = "Environment for the terraform deployment"
}
