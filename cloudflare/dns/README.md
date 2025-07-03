<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_dns_record.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_zone.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_defaults"></a> [defaults](#input\_defaults) | Default values for DNS records. These will be used if not specified in the records. | <pre>object({<br/>    value   = optional(string)<br/>    type    = optional(string)<br/>    proxied = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_records_by_zone"></a> [records\_by\_zone](#input\_records\_by\_zone) | Map of DNS records by zone. Each key is a zone name and the value is a list of records for that zone. | <pre>map(list(object({<br/>    name    = string<br/>    value   = optional(string)<br/>    type    = optional(string)<br/>    proxied = optional(bool)<br/>    id      = optional(string, "")<br/>  })))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_records_by_zone"></a> [records\_by\_zone](#output\_records\_by\_zone) | Map of DNS records by zone. Each key is a zone name and the value is a list of records for that zone. |
<!-- END_TF_DOCS -->