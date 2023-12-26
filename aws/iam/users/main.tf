terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18"
    }
  }
}

resource "aws_iam_user" "this" {
  for_each = var.users

  name          = each.key
  force_destroy = true

  tags = try(each.value.tags, {})
}

resource "aws_iam_access_key" "this" {
  for_each = var.users

  user = each.key

  depends_on = [
    aws_iam_user.this
  ]
}

resource "aws_iam_user_policy" "this" {
  for_each = local.users_with_inline_policy

  user   = each.key
  policy = each.value.policy

  depends_on = [
    aws_iam_user.this
  ]
}

resource "aws_iam_user_group_membership" "user_groups" {
  for_each = aws_iam_user.this

  user   = each.key
  groups = lookup(var.users[each.key], "groups", [])
}

resource "aws_iam_user_policy_attachment" "user_attached_policies" {
  for_each = local.user_attached_policies

  user       = each.value.user
  policy_arn = each.value.policy_arn

  depends_on = [
    aws_iam_user.this
  ]
}
