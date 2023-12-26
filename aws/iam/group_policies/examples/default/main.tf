provider "aws" {
  region = "us-east-1"
}

module "policies_and_groups" {
  source = "../.."

  policies = {
    SamplePolicy = {
      file        = "files/SamplePolicy.json"
      description = "Sample policy just for test."
      path        = "/"
      tags        = {}
    }

    SampleInlinePolicy = {
      content_obj = {
        Version = "2012-10-17",
        Statement = [
          {
            Sid      = "ViewAccountPasswordRequirements",
            Effect   = "Allow",
            Action   = "iam:GetAccountPasswordPolicy",
            Resource = "*"
          }
        ]
      }

      description = "Sample policy just for test."
      path        = "/"
      tags        = {}
    }

    SampleStringPolicy = {
      content     = file("files/SamplePolicy.json")
      description = "Sample policy just for test."
      path        = "/"
      tags        = {}
    }
  }

  groups = {
    SampleDevOps = [
      "SamplePolicy",
      "arn:aws:iam::aws:policy/AdministratorAccess",
    ]

    AnotherGroup = [
      "SamplePolicy"
    ]
  }

  roles = {
    Developer = {
      tags = {}

      assume_role_policy = {
        Version = "2012-10-17"
        Statement = [
          {
            Sid    = "AssumeDeveloperRolePolicy"
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
              "AWS" = "*"
            }
          },
        ]
      }

      policies = [
        "SamplePolicy",
        "arn:aws:iam::aws:policy/AdministratorAccess",
      ]
    }
  }
}

output "module_outputs" {
  value = module.policies_and_groups
}
