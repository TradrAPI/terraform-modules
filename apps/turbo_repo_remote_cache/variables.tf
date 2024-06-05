variable "name" {
  type        = string
  description = "The name of the Bucket and Lambda function"
}
variable "extra_environment_variables" {
  type    = map(string)
  default = {}
}