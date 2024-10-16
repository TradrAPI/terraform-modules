output "user" {
  value = (
    !var.create_user
    ? null
    : {
      user_arn              = aws_iam_user.kms[0].arn
      AWS_ACCESS_KEY_ID     = aws_iam_access_key.kms[0].id
      AWS_SECRET_ACCESS_KEY = aws_iam_access_key.kms[0].secret
    }
  )
}

output "key" {
  value = aws_kms_key.this
}

output "key_alias" {
  value = merge(aws_kms_alias.this, {
    name = "alias/${local.names.fqn}"
  })
}

output "policy_arn" {
  value = try(aws_iam_policy.kms[0].arn, null)
}
