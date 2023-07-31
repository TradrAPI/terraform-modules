module "infra_store" {
  source = "../../utils/infra_store"
}

data "cloudflare_zone" "this" {
  for_each = local.domains

  name = each.value
}

data "aws_s3_bucket" "this" {
  count = var.create_bucket ? 0 : 1

  bucket = "${var.environment}-frontend-all"
}
