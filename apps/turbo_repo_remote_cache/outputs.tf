output "lambda_function_url" {
  value = module.lambda.lambda_function_url
}

output "turbo_token" {
  value     = random_password.turbo_token.result
  sensitive = true
}
