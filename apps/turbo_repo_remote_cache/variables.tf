variable "name" {
  type        = string
  description = "The name of the Bucket and Lambda function"
}

variable "timeout" {
  type    = number
  default = 10
}

variable "pre_commands" {
  type = list(string)

  default = []
}

variable "extra_environment_variables" {
  type    = map(string)
  default = {}
}
