# Terraform Secret module

## Example

```
module "apm_token_to" {
  source   = "git@github.com:TradrAPI/terraform-modules.git//aws/secrets?ref=v1.0.1"
  name     = "APM/TOKEN"
  platform = "TRADEOR"
  secret   = var.token
}
```
