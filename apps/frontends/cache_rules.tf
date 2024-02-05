resource "cloudflare_ruleset" "cache_rules_api" {

  for_each = {
    for partition, data in var.partitions : partition => data 
    if contains(keys(data), "api")
  }

  zone_id     = data.cloudflare_zone.this[each.key].id
  name        = "Set cache settings for /fe-settings"
  description = "Set cache settings for /fe-settings"
  kind        = "zone"
  phase       = "http_request_cache_settings"

  rules {
    action = "set_cache_settings"
    action_parameters {
      edge_ttl {
        mode    = "override_origin"
        default = 60
        status_code_ttl {
          status_code = 200
          value       = 50
        }
        status_code_ttl {
          status_code_range {
            from = 201
            to   = 300
          }
          value = 30
        }
      }
      serve_stale {
        disable_stale_while_updating = true
      }
      respect_strong_etags = false
      cache_key {
        cache_deception_armor      = false
        ignore_query_strings_order = false
        custom_key {
          query_string {
            exclude = ["*"]
          }
        }
      }
      origin_error_page_passthru = false
    }
    expression = "(http.request.uri.path contains \"/fe-settings\")"

    description = "Set cache settings and custom cache key for api.domain.com/fe-settings"
    enabled     = true
  }
}