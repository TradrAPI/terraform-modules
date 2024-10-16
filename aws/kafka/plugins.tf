locals {
  plugins = {
    # Write data from kafka to s3 backup
    "amazon-s3-sink-connector" = {
      url = "https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-s3/versions/10.5.5/confluentinc-kafka-connect-s3-10.5.5.zip"
    }
    # Write data from s3 to kafka restore
    "amazon-s3-source-connector" = {
      url = "https://github.com/lensesio/stream-reactor/releases/download/6.0.0/kafka-connect-aws-s3-6.0.0.zip"
    }
  }
}

module "mskconnect_custom_plugins" {
  source = "github.com/TradrApi/terraform-modules//aws/s3?ref=v1"

  bucket_name = "${var.environment}-${var.platform}-mskconnect-custom-plugins"

  block_public_access = true
  create_bucket_acl   = false
}



resource "aws_s3_object" "plugins" {
  for_each = local.plugins

  bucket = module.mskconnect_custom_plugins.bucket_id

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



resource "aws_mskconnect_custom_plugin" "plugins" {
  for_each = local.plugins

  name         = "${var.platform}-${var.environment}-${each.key}"
  content_type = "ZIP"

  location {
    s3 {
      bucket_arn = module.mskconnect_custom_plugins.bucket.arn
      file_key   = aws_s3_object.plugins[each.key].key
    }
  }
}



resource "terraform_data" "plugins" {
  for_each = local.plugins

  triggers_replace = [
    each.value.url
  ]

  provisioner "local-exec" {
    command = "curl -o ${each.key}.zip -LO ${each.value.url}"
  }
}

