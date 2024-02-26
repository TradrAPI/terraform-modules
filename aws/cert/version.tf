terraform {
  required_version = ">= 1.0.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
    }

    aws = {
      source  = "hashicorp/aws"
    }
  }
}
