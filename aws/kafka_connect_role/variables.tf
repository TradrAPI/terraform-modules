variable "role_name" {
  description = "The name of the IAM role to create for Kafka Connect."
  type        = string
}

variable "cluster_name" {
  description = "The name of the MSK cluster."
  type        = string
}

variable "cluster_id" {
  description = "The ID of the MSK cluster."
  type        = strings
}

variable "extra_policies_arns" {
  description = "List of additional IAM policy ARNs to attach to the role."
  type        = list(string)
  default     = []
}
