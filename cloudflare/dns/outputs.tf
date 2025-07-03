output "records_by_zone" {
  description = "Map of DNS records by zone. Each key is a zone name and the value is a list of records for that zone."

  value = {
    for zone, records in var.records_by_zone :
    zone => [
      for record in records :
      cloudflare_dns_record.this["${record.name}.${zone}"]
    ]
  }
}
