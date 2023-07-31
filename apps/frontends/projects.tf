resource "cloudflare_record" "brands" {
  for_each = {
    for fqdn, record in local.records:
    fqdn => record
    if !record.is_skipped_record
  }

  zone_id = data.cloudflare_zone.this[each.value.domain].id
  type    = module.infra_store.const.cname_record
  name    = each.value.subdomain

  value = each.value.variant

  allow_overwrite = var.allow_record_overwrite

  proxied = true
}
