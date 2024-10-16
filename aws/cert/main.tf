resource "aws_acm_certificate" "cert" {
  domain_name       = "*.${local.full_domain}"
  validation_method = "DNS"

  tags = {
    Domain      = local.full_domain
    Environment = var.deployment_env
    Created-By  = "DevOps-Terraform"
  }
}

data "cloudflare_zones" "domain" {
  filter {
    name        = var.domain
    lookup_type = "exact"
    status      = "active"
  }
}

resource "cloudflare_record" "domain" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name  = dvo.resource_record_name
      value = dvo.resource_record_value
      type  = dvo.resource_record_type
    }
  }

  zone_id = data.cloudflare_zones.domain.zones[0].id

  name            = trimsuffix(each.value.name, ".${var.domain}.")
  content         = trimsuffix(each.value.value, ".")
  type            = each.value.type
  proxied         = false
  allow_overwrite = true
  depends_on      = [aws_acm_certificate.cert]
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = aws_acm_certificate.cert.arn
  depends_on      = [cloudflare_record.domain]
}

locals {
  full_domain = (
    var.subdomain != null
    ? "${var.subdomain}.${var.domain}"
    : var.domain
  )
}
