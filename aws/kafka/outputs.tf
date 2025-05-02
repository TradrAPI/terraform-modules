output "msk_brokers_by_auth_method" {
  description = "Map of brokers list by authentication method. The list on each key is a comma-separated list of brokers"
  value = {
    sasl_scram = aws_msk_cluster.this.bootstrap_brokers_sasl_scram
    sasl_iam   = aws_msk_cluster.this.bootstrap_brokers_sasl_iam
  }
}

output "msk_sasl_scram_users" {
  description = "Map of user names to their passwords"

  value = {
    for user in var.users :
    user => random_password.msk[user].result
  }

  sensitive = true
}
