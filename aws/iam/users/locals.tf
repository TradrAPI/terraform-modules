locals {
  users_with_inline_policy = {
    for name, definition in var.users :
    name => definition
    if definition.policy != null
  }

  users_with_attached_policies = {
    for name, definition in var.users :
    name => definition
    if length(definition.attached_policies_arns) > 0
  }

  _user_attached_policies = flatten([
    for user, info in local.users_with_attached_policies : [
      for policy_arn in info.attached_policies_arns : {
        fqn        = "${user}/${policy_arn}"
        policy_arn = policy_arn
        user       = user
      }
    ]
  ])

  user_attached_policies = {
    for info in local._user_attached_policies :
    info.fqn => info
  }
}
