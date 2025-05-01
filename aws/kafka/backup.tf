module "msk_backup" {
  source = "../kafka_backup"

  resources_prefix = "${var.platform}-${var.environment}"

  create_backup_bucket = true
  bucket_lifetime_days = 14


  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets

  msk_cluster         = aws_msk_cluster.this
  plugins_bucket_name = module.mskconnect_plugins.bucket_name

  connector = {
    kafkaconnect_version  = "2.7.1"
    log_retention_in_days = 3

    capacity_autoscaling = {
      mcu_count        = 1
      max_worker_count = 2
      min_worker_count = 1

      scale_in_cpu_utilization_percentage  = 10
      scale_out_cpu_utilization_percentage = 80
    }

    connector_configuration = {
      "format.class"                   = "io.confluent.connect.s3.format.json.JsonFormat"
      "flush.size"                     = "3"
      "schema.compatibility"           = "NONE"
      "tasks.max"                      = "2"
      "partitioner.class"              = "io.confluent.connect.storage.partitioner.DefaultPartitioner"
      "storage.class"                  = "io.confluent.connect.s3.storage.S3Storage"
      "topics.dir"                     = "topics"
      "topics.regex"                   = "^(?!__).*"
      "behavior.on.null.values"        = "ignore"
      "value.converter"                = "org.apache.kafka.connect.json.JsonConverter"
      "value.converter.schemas.enable" = "false"
    }
  }
}

module "mskconnect_plugins" {
  source = "../kafka_plugins"

  bucket_name   = "${var.environment}-${var.platform}-mskconnect-custom-plugins"
  create_bucket = true

  plugins = {}
}
