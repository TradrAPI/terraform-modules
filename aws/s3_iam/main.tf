locals {
  policies = {
    (var.policy) = {
      content_obj = {
        Version = "2012-10-17"
        Statement = [
          {
            Effect = "Allow"
            Action = [
              "s3:*"
            ]
            Resource = [
              "arn:aws:s3:::${var.bucket_id}",
              "arn:aws:s3:::${var.bucket_id}/*"
            ]
          }
        ]
      }
    }
  }

  groups = {
    (var.group) = [var.policy]
  }

  roles = (
    var.role == null
    ? {}
    : {
      (var.role) = {
        tags = {}

        policies = [var.policy]

        assume_role_policy = {
          Version = "2012-10-17"
          Statement = [
            {
              Effect = "Allow"
              Principal = {
                Service = [
                  "s3.amazonaws.com"
                ]
              }
              Action = [
                "sts:AssumeRole"
              ]
            }
          ]
        }
      }
    }
  )

  users = {
    (var.user) = {
      groups = [var.group]
    }
  }
}

module "iam_structures" {
  source = "../IAM/POLICIES_ROLES_AND_GROUPS"

  policies = local.policies
  groups   = local.groups
  roles    = local.roles
}

data "aws_region" "this" {}

module "users" {
  source = "../IAM/USERS"

  users = local.users

  depends_on = [
    module.iam_structures
  ]
}
