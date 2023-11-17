output "policies" {
  value = { for name, policy in aws_iam_policy.this : name => policy.arn }
}

output "groups" {
  value = local.aws_iam_groups
}

output "roles" {
  value = { for name, role in aws_iam_role.this : name => role.arn }
}
