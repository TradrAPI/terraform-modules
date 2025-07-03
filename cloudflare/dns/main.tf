resource "cloudflare_dns_record" "this" {
  for_each = local.records

  zone_id = data.cloudflare_zone.this[each.value.zone].zone_id

  name    = each.key
  content = each.value.value
  type    = each.value.type
  proxied = each.value.proxied

  ttl = 1 # Auto TTL

  comment = "terraform-workspace: ${terraform.workspace}"

  depends_on = [
    data.cloudflare_zone.this,
  ]
}

locals {
  records = {
    for r in local._records :
    "${r.name}.${r.zone}" => r
  }

  _records = flatten([
    for zone, records in var.records_by_zone : [
      for record in records : {
        zone    = zone
        name    = record.name
        value   = lookup(record, "value", var.defaults.value)
        type    = lookup(record, "type", var.defaults.type)
        proxied = lookup(record, "proxied", var.defaults.proxied)
        id      = lookup(record, "id", "")
      }
    ]
  ])
}

data "cloudflare_zone" "this" {
  for_each = var.records_by_zone

  filter = {
    name = each.key
  }
}
