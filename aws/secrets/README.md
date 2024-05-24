# Terraform Secret module

## Example

```
module "apm_token_to" {
  source   = "github.com/TradrAPI/terraform-modules.git//aws/secrets?ref=add-secrets-modules"

  name     = "APM/TOKEN"
  secret   = var.token
}
```
