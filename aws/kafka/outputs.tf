output "msk_brokers_by_auth_method" {
  value = {
    sasl_scram = aws_msk_cluster.this.bootstrap_brokers_sasl_scram
    sasl_iam   = aws_msk_cluster.this.bootstrap_brokers_sasl_iam
  }
}

output "msk_sasl_scram_users" {
  value = {
    for user in var.users :
    user => random_password.msk[user].result
  }

  sensitive = true
}
