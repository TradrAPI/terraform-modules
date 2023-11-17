# GENERIC/IAM/USERS module

Used to manage IAM users.

## Required variables

`users` - A map from username to user definition, where the definition has the following structure
  - `email` (optional) - slack workspace email. If an email is not provided, the user is considered non interactive and access keys will be created and made available as module output
  - `groups` (optional) - Array of group names this user belongs to
  - `team_name` (optional, defaults to `"None"`) - Team the user belongs to in the organization
  - `access_profiles` (optional) - ignored if email is not definied. list of access profiles of the user. Allowed values are `cli` and `console`. Programmatic access credentials are created if `cli` is passed and UI console credentials are created if `console` is passed. Both types of credentials are created if both type of access are specified
  - `tags` (optional) - A `map(string)` from tag name to tag value
  - `policy` - terraform object specifying a user IAM policy

## Optional variables

`slack_bot_token` - Used to send messages as Slack Bot. Required when creating interactive users. Defaults to `""`

`account_alias` - Sent as account name on the user credentials message. Defaults to `""`

`assume_role_arn` - If you're assuming a role in the terraform provider you'll need this to create users on the right account. Defaults to `null`

`region` - Used to create random secrets for user passwords. Defaults to `us-east-1`

## Scope of this module

`aws_iam_user`

`aws_iam_user_group_membership`

## Examples


### Module basic usage
```terraform
module "users" {
  source = "../.."

  region          = "us-east-2"
  account_alias   = "awsAccountName"
  slack_bot_token = "top-secret-token"

  users = {
    "test.user" = {
      team_name       = "DevOps"
      email           = "someuser@gmail.com"
      groups          = ["DevOps"]
      access_profiles = ["console", "cli"]
      tags = {
        Environment = "Development"
      }
    }

    "test.non_interactive_user" = {
      team_name = "Automation"
      groups    = ["S3ReadOnly"]
    }
  }
}
```

## Outputs

`names`: names of the users created

`group_memberships`: map from user names to groups it belongs to
