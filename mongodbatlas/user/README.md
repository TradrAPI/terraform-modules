<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_mongodbatlas.creds"></a> [mongodbatlas.creds](#provider\_mongodbatlas.creds) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [mongodbatlas_database_user.user](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/database_user) | resource |
| [random_password.iv](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [external_external.encrypt](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [mongodbatlas_cluster.this](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/data-sources/cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_brandname"></a> [brandname](#input\_brandname) | n/a | `string` | `""` | no |
| <a name="input_connection_string_shards"></a> [connection\_string\_shards](#input\_connection\_string\_shards) | define whether to use the connection string with the shards or not, see here for more information https://www.mongodb.com/docs/manual/reference/connection-string/ | `bool` | `true` | no |
| <a name="input_create_outputs"></a> [create\_outputs](#input\_create\_outputs) | only set to true if there is at least 1 item in mongodb\_clusters and 1 item in mongodb\_permissions. It will always use the values in the first item | `bool` | `false` | no |
| <a name="input_encryption_key"></a> [encryption\_key](#input\_encryption\_key) | n/a | `string` | `null` | no |
| <a name="input_external_password"></a> [external\_password](#input\_external\_password) | n/a | `string` | `null` | no |
| <a name="input_external_username"></a> [external\_username](#input\_external\_username) | n/a | `string` | `null` | no |
| <a name="input_mongodb_clusters"></a> [mongodb\_clusters](#input\_mongodb\_clusters) | n/a | `list(string)` | `[]` | no |
| <a name="input_mongodb_permissions"></a> [mongodb\_permissions](#input\_mongodb\_permissions) | n/a | <pre>list(object({<br/>    dbname = string<br/>    role = string<br/>  }))</pre> | n/a | yes |
| <a name="input_mongodb_projectid"></a> [mongodb\_projectid](#input\_mongodb\_projectid) | The mongodb project id, which can be found in project settings | `string` | n/a | yes |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | n/a | `string` | `"-user"` | no |
| <a name="input_platform"></a> [platform](#input\_platform) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iv"></a> [iv](#output\_iv) | n/a |
| <a name="output_mongodb_password"></a> [mongodb\_password](#output\_mongodb\_password) | n/a |
| <a name="output_mongodb_uri"></a> [mongodb\_uri](#output\_mongodb\_uri) | n/a |
| <a name="output_mongodb_uri_encrypted"></a> [mongodb\_uri\_encrypted](#output\_mongodb\_uri\_encrypted) | n/a |
| <a name="output_mongodb_uri_shards"></a> [mongodb\_uri\_shards](#output\_mongodb\_uri\_shards) | n/a |
| <a name="output_mongodb_username"></a> [mongodb\_username](#output\_mongodb\_username) | n/a |
| <a name="output_this"></a> [this](#output\_this) | n/a |
<!-- END_TF_DOCS -->