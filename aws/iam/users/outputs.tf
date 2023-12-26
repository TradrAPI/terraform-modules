output "names" {
  value = [for user in aws_iam_user.this : user.name]
}

output "arns" {
  value = [for user in aws_iam_user.this : user.arn]
}

output "access_keys" {
  value = {
    for name, definition in var.users :
    name => {
      id        = aws_iam_access_key.this[name].id
      secret    = aws_iam_access_key.this[name].secret
      smtp_pass = aws_iam_access_key.this[name].ses_smtp_password_v4
    }
  }

  sensitive = true
}

output "group_memberships" {
  value = {
    for user, membership in aws_iam_user_group_membership.user_groups :
    user => membership.groups
  }
}

output "users" {
  value = {
    for user in aws_iam_user.this :
    user.name => {
      arn    = user.arn
      name   = user.name
      groups = try(aws_iam_user_group_membership.user_groups[user.name], [])

      access_key = try({
        id        = aws_iam_access_key.this[user.name].id
        secret    = aws_iam_access_key.this[user.name].secret
        smtp_pass = aws_iam_access_key.this[user.name].ses_smtp_password_v4
      }, {})
    }
  }
}
