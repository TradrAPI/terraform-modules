variable "bucket_name" {
  type = string
}

variable "role_name" {
  type    = string
  default = "TurborepoRemoteCache"
}

variable "lambda_name" {
  type    = string
  default = "turborepo-cache-lambda"
  
}