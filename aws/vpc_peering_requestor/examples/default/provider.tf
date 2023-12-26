terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.18"
    }
  }
}

provider "aws" {
  region = local.region
}
