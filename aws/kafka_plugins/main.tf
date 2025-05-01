module "plugins_bucket" {
  count = var.create_bucket ? 1 : 0

  source = "../s3"

  bucket_name = var.bucket_name

  block_public_access = true
  create_bucket_acl   = false
}

resource "aws_s3_object" "plugins" {
  for_each = var.plugins

  bucket = (
    var.create_bucket
    ? module.plugins_bucket[0].bucket_id
    : var.bucket_name
  )

  key    = "${each.key}.zip"
  source = "${each.key}.zip"

  depends_on = [
    terraform_data.plugins
  ]

  lifecycle {
    replace_triggered_by = [
      terraform_data.plugins[each.key]
    ]
  }
}

data "aws_s3_bucket" "plugins" {
  count = var.create_bucket ? 0 : 1

  bucket = var.bucket_name
}

resource "aws_mskconnect_custom_plugin" "plugins" {
  for_each = var.plugins

  name         = coalesce(each.value.alias, each.key)
  content_type = "ZIP"

  location {
    s3 {
      file_key = aws_s3_object.plugins[each.key].key

      bucket_arn = (
        var.create_bucket
        ? module.plugins_bucket[0].bucket.arn
        : data.aws_s3_bucket.plugins[0].arn
      )
    }
  }
}

resource "terraform_data" "plugins" {
  for_each = var.plugins

  triggers_replace = [
    each.value.url
  ]

  provisioner "local-exec" {
    command = "curl -o ${each.key}.zip -LO ${each.value.url}"
  }
}
