# GENERIC/IAM/POLICIES_ROLES_AND_GROUPS module

Used to configure policies, roles and groups associated to them.

[[_TOC_]]

## Required variables

`policies`: map from policy name to definition. The definition has the structure bellow
  - `you must pass one of these`: listed here by priority order (if defined in the same object, the higher priority item takes precedence)
    - `file`: relative path to policy definition file inside the root module, templates are not supported yet
    - `content_obj`: terraform object representation of the policy
    - `content`: string representing the policy, useful for passing the results of `file(...)` or `templatefile(...)` to the module
  - `description` (optional): must explain the policy briefly
  - `path` (optional): policy path
  - `tags` (optional): tags to be attached to the policy created

`groups`: map from group name to policies
  - policies passed in by name are treated as being created by this module
  - policies passed in by ARN are only read

`roles`: map from role name to role definition
  - `assume_role_policy`: object describing the AssumeRole policy (later encoded as a json string by the module)
  - `policies`: array of policies names or ARNs
    - policies passed in by name are treated as being created by this module
    - policies passed in by ARN are only read

`skip_group_creation` (optional, default `false`): whether to create groups or fetch them from the cloud.

## Scope of this module

`aws_iam_group`

`aws_iam_group_policy_attachment`

`aws_iam_role`

`aws_iam_role_policy_attachment`

`aws_iam_policy`

## Examples

```terraform
module "policies_roles_and_groups" {
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
```

## Outputs

`groups`: map from group names to group ARNs of the groups created by the module

`roles`: map from role names to role ARNs of the roles created by the module

`created_policies_arns`: ARNs for the policies created by the module

`group_policy_attachments`: map of attachment_key to attachment object

`role_policy_attachments`: map of attachment_key to attachment object
