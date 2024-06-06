provider "aws" {}

module "turborepo_remote_cache" {
  source = "../.."

  name = "turborepo-remote-cache-test-leo"

  extra_environment_variables = {
    STORAGE_PROVIDER = "this-won't-be-used"
    LOG_LEVEL        = "debug"
  }
}

output "lambda_function_url" {
  value = module.turborepo_remote_cache.lambda_function_url
}

output "turbo_token" {
  value     = module.turborepo_remote_cache.turbo_token
  sensitive = true
}
