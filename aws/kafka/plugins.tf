module "mskconnect_plugins" {
  source = "../kafka_plugins"

  bucket_name   = "${var.environment}-${var.platform}-mskconnect-custom-plugins"
  create_bucket = true

  plugins = {
    # Write data from kafka to s3 backup
    "amazon-s3-sink-connector" = {
      alias = "${var.platform}-${var.environment}-amazon-s3-sink-connector"
      url   = "${var.amazon_s3_sink_connector_url}"
    }
    # Write data from s3 to kafka restore
    "amazon-s3-source-connector" = {
      alias = "${var.platform}-${var.environment}-amazon-s3-source-connector"
      url   = "https://github.com/lensesio/stream-reactor/releases/download/6.0.0/kafka-connect-aws-s3-6.0.0.zip"
    }
  }
}

moved {
  from = module.mskconnect_custom_plugins
  to   = module.mskconnect_plugins.plugins_bucket[0]
}

moved {
  from = aws_s3_object.plugins
  to   = module.mskconnect_plugins.aws_s3_object.plugins
}

moved {
  from = aws_mskconnect_custom_plugin.plugins
  to   = module.mskconnect_plugins.aws_mskconnect_custom_plugin.plugins
}

moved {
  from = terraform_data.plugins
  to   = module.mskconnect_plugins.terraform_data.plugins
}
