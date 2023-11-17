provider "aws" {
  region = "us-east-2"
}

resource "aws_iam_group" "sample" {
  name = "SampleGroup"
}

module "users" {
  source = "../.."

  users = {
    "test.user" = {
      groups = [aws_iam_group.sample.name]

      tags = {
        Created-By = "DevOps Team"
      }

      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "ec2:Describe*",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      })
    }

    "test.user_empty" = {}

    "test.user_policy_arns" = {
      attached_policies_arns = [
        "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
      ]
    }

    "test.user_inline_and_attached_policies" = {
      attached_policies_arns = [
        "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
      ]

      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "ec2:Describe*",
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
      })
    }
  }
}

output "user_names" {
  value = module.users.names
}

output "user_group_memberships" {
  value = module.users.group_memberships
}
