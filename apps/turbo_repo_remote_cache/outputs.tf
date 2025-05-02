output "lambda_function_url" {
  value = var.create_lambda ? module.lambda[0].lambda_function_url : null
}

output "turbo_token" {
  value     = random_password.turbo_token.result
  sensitive = true
}
