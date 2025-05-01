variable "resources_prefix" {
  description = "The prefix to use for the resources created by this module"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The VPC ID to deploy the connector in"
  type        = string
  default     = ""
}

variable "plugins_bucket_name" {
  description = "The name of the S3 bucket to store the plugins"
  type        = string
}

variable "private_subnets" {
  description = "The private subnets to deploy the connector in"
  type        = list(string)
  default     = []

}

variable "msk_cluster" {
  description = "The MSK cluster to backup. A cluster resource object can be passed directly"

  type = object({
    arn                        = string
    bootstrap_brokers_sasl_iam = string
  })
}

variable "create_backup_bucket" {
  description = "Whether to create the S3 bucket to store the backups"
  type        = bool
  default     = true
}

variable "backup_bucket_name" {
  description = "The name of the S3 bucket to store the backups"
  type        = string
  default     = ""

}

variable "bucket_lifetime_days" {
  description = "The number of days to keep the backups in the S3 bucket"
  type        = number
  default     = 14
}

variable "log_retention_in_days" {
  description = "The number of days to keep the logs in CloudWatch"
  type        = number
  default     = 3
}

variable "connector" {
  type = object({
    kafkaconnect_version  = optional(string, "2.7.1")
    log_retention_in_days = optional(number, 3)

    sink_connector_url = optional(
      string,
      "https://d2p6pa21dvn84.cloudfront.net/api/plugins/confluentinc/kafka-connect-s3/versions/10.5.2/confluentinc-kafka-connect-s3-10.5.2.zip"
    )

    capacity_autoscaling = object({
      mcu_count        = optional(number, 1)
      max_worker_count = optional(number, 2)
      min_worker_count = optional(number, 1)

      scale_in_cpu_utilization_percentage  = optional(number, 10)
      scale_out_cpu_utilization_percentage = optional(number, 80)
    })

    connector_configuration = optional(map(string), {
      "format.class"                   = "io.confluent.connect.s3.format.json.JsonFormat"
      "flush.size"                     = "1"
      "schema.compatibility"           = "NONE"
      "tasks.max"                      = "2"
      "partitioner.class"              = "io.confluent.connect.storage.partitioner.DefaultPartitioner"
      "storage.class"                  = "io.confluent.connect.s3.storage.S3Storage"
      "topics.dir"                     = "topics"
      "topics.regex"                   = "^(?!__).*"
      "behavior.on.null.values"        = "ignore"
      "value.converter"                = "org.apache.kafka.connect.json.JsonConverter"
      "value.converter.schemas.enable" = "false"
    })
  })
}

variable "kafkaconnect_version" {
  description = "The version of the Kafka Connect to use in the connector"
  type        = string
  default     = "2.7.1"
}
