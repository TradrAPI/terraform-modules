# GENERIC/S3_IAM module

Allows creating policy, role, group and user with access to a given bucket.

[[_TOC_]]

## Required variables

- `bucket_id` - iam structures will have read write permissions on this bucket
- `policy` - name of the bucket policy
- `group` - name of the group associated to the policy
- `role` - name of a role with the policy attached
- `user` - programmatic user added to the created `group`

## Scope of this module

`module.users`

`module.iam_structures`

## Examples

```terraform
module "bucket_iam" {
  source = "../.."

  bucket_id = module.bucket.bucket_id # or some other bucket id

  policy = "TestContentReadWrite"
  role   = "TestContentS3"
  group  = "TestContentS3"
  user   = "test-content.admin"
}
```

## Outputs

`group` - object containing the created group `arn` and `name`
`role` - object containing the created role `arn` and `name`
`policy` - object containing the created policy `name`
`user` - object containing the created user `name` and `access_keys`, where `access keys` is an object with `id` and `secret` fields
