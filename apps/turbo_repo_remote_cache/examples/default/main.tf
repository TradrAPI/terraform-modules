provider "aws" {}

module "turborepo_remote_cache" {
  source = "../.."

  bucket_name = "turborepo-remote-cache"
}
