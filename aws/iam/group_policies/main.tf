terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18"
    }
  }
}

locals {
  default_tags = {
    "Created-By" = "Terraform"
  }

  arn_regex = "^arn:"

  aws_iam_groups = (
    var.skip_group_creation
    ? { for name, group in data.aws_iam_group.this : name => group.arn }
    : { for name, group in aws_iam_group.this : name => group.arn }
  )

  groups = (
    var.skip_group_creation
    ? {}
    : var.groups
  )

  group_attachments = flatten([
    for name, policies in var.groups : [
      for policy in toset(policies) : {
        group  = name
        policy = policy
        policy_arn = (
          can(regex(local.arn_regex, policy))
          ? policy
          : aws_iam_policy.this[policy].arn
        )
      }
      if can(regex(local.arn_regex, policy)) || contains(keys(aws_iam_policy.this), policy)
    ]
  ])

  role_attachments = flatten([
    for name, definition in var.roles : [
      for policy in toset(definition.policies) : {
        role   = name
        policy = policy
        policy_arn = (
          can(regex(local.arn_regex, policy))
          ? policy
          : aws_iam_policy.this[policy].arn
        )
      }
      if can(regex(local.arn_regex, policy)) || contains(keys(aws_iam_policy.this), policy)
    ]
  ])
}

resource "aws_iam_policy" "this" {
  for_each = var.policies

  name        = each.key
  description = try(each.value.description, "")
  path        = try(each.value.path, "/")
  tags        = merge(try(each.value.tags, {}), local.default_tags)

  policy = try(
    file("${path.root}/${each.value.file}"), # Check if it's a path to a policy file (previous module default behaviour)
    jsonencode(each.value.content_obj),      # Check if it's a terraform object representing a policy definition
    each.value.content,                      # fall back to handling it as string
  )
}

resource "aws_iam_group" "this" {
  for_each = local.groups

  name = each.key

  depends_on = [
    aws_iam_policy.this
  ]
}

resource "aws_iam_group_policy_attachment" "this" {
  for_each = {
    for ga in local.group_attachments : "${ga.group}/${ga.policy}" => {
      group      = ga.group
      policy_arn = ga.policy_arn
    }
  }

  group      = each.value.group
  policy_arn = each.value.policy_arn

  depends_on = [
    aws_iam_group.this,
    aws_iam_policy.this,
  ]
}

resource "aws_iam_role" "this" {
  for_each = var.roles

  name               = each.key
  tags               = try(each.value.tags, {})
  assume_role_policy = jsonencode(each.value.assume_role_policy)

  depends_on = [
    aws_iam_policy.this
  ]
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for ra in local.role_attachments : "${ra.role}/${ra.policy}" => {
      role       = ra.role
      policy_arn = ra.policy_arn
    }
  }

  role       = each.value.role
  policy_arn = each.value.policy_arn

  depends_on = [
    aws_iam_role.this,
    aws_iam_policy.this,
  ]
}
