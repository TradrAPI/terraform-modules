provider "aws" {
  region = "us-east-2"
}

module "kms" {
  source = "../.."

  name = "test-key-deleteme-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  numeric = false
}
