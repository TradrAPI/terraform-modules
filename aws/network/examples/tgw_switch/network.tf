module "network" {
  source = "../.."

  az_zones = data.aws_availability_zones.current.names
  region   = "eu-west-2"
  vpc_sub  = "10.66"

  name           = "test"
  deployment_env = "test-vpc"

  amazon_side_asn                     = var.amazon_side_asn
  enable_tgw_routes_in_public_subnets = true

  tgw_cidrs = [
    "10.0.0.0/8", # any non local traffic goes through the TGW
  ]

  extra_private_routes = []
  extra_public_routes  = []
}

data "aws_availability_zones" "current" {
  state = "available"
}
