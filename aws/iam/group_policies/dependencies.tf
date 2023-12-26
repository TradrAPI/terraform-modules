data "aws_iam_group" "this" {
  for_each = var.skip_group_creation ? var.groups : {}

  group_name = each.key
}
