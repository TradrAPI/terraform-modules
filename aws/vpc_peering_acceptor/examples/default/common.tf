locals {
  region   = "us-east-2"
  az_zones = ["${local.region}a", "${local.region}b"]

  requester_cidr = {
    short = "10.83"
    full  = "10.83.0.0/16"
  }

  accepter_cidr = {
    short = "10.93"
    full  = "10.93.0.0/16"
  }
}

data "aws_caller_identity" "current" {}

