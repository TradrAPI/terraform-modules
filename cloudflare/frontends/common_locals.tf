locals {
  domains = toset(var.domains)

  const = {
    external_prefix = "external:"
    skipped_records_prefix = "skiprecord:"
  }

  _records = [
    for domain, config in var.partitions :
    {
      for subdomain, variant in config :
      "${subdomain}.${domain}" => {
        subdomain         = subdomain
        domain            = domain
        fqdn              = "${subdomain}.${domain}"
        variant           = trimprefix(trimprefix(variant, local.const.external_prefix), local.const.skipped_records_prefix)
        is_external       = startswith(variant, local.const.external_prefix)
        is_skipped_record = startswith(variant, local.const.skipped_records_prefix)
      }
    }
  ]

  records = merge(local._records...)
}
