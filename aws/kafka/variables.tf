
variable "platform" {
  description = "Platform name"
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "MSK cluster name"
  type        = string
  default     = null
}

variable "kafka_version" {
  description = "Kafka version (See https://docs.aws.amazon.com/msk/latest/developerguide/supported-kafka-versions.html)"
  type        = string
  default     = "3.4.0"

}

variable "number_of_broker_nodes" {
  description = "Number of broker nodes"
  type        = number
  default     = 3
}

variable "client_subnets" {
  description = "Client VPC subnets"
  type        = list(string)
  default     = []
}

variable "msk_instance_type" {
  description = "MSK instance type (See https://docs.aws.amazon.com/msk/latest/developerguide/broker-instance-sizes.html)"
  type        = string
  default     = "kafka.t3.small"

}

variable "ebs_volume_size" {
  description = "EBS volume size (in GiB) for each broker node"
  type        = number
  default     = 10
}

variable "vpc_id" {
  description = "ID of the VPC where the MSK cluster will be created"
  type        = string
  default     = null
}

variable "allowed_cidr_blocks" {
  description = "Allowed CIDR blocks that can access the MSK cluster"
  type        = list(string)
  default     = []

}

variable "users" {
  description = "MSK users names list (passwords are generated automatically)"
  type        = list(string)
  default     = []
}

variable "server_properties" {
  description = <<-EOF
    Server properties. You can specify any of the properties in https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html.

    Example:

    ```
    server_properties = <<-EOF2
      auto.create.topics.enable=true
      delete.topic.enable=true
    EOF2
    ```
  EOF
  type        = string
  default     = null
}

variable "default_num_partitions" {
  description = "Default number of partitions (>= number_of_broker_nodes is recommended)"
  type        = number
  default     = null
  nullable    = true
}
