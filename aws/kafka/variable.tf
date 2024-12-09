
variable "amazon-s3-sink-connector-url" {
  description = "Amazon S3 Sink Connector URL"
  type        = string
  default     = "https://d2p6pa21dvn84.cloudfront.net/api/plugins/confluentinc/kafka-connect-s3/versions/10.5.2/confluentinc-kafka-connect-s3-10.5.2.zip"
}
variable "platform" {
  description = "Platform name."
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = null
}

variable "cluster_name" {
  description = "msk cluster name."
  type        = string
  default     = null
}


variable "kafka_version" {
  description = "Kafka version."
  type        = string
  default     = "3.4.0"

}


variable "number_of_broker_nodes" {
  description = "Number of broker nodes."
  type        = number
  default     = 3
}

variable "client_subnets" {
  description = "Client subnets."
  type        = list(string)
  default     = []

}

variable "msk_instance_type" {
  description = "MSK instance type."
  type        = string
  default     = "kafka.t3.small"

}

variable "ebs_volume_size" {
  description = "EBS volume size."
  type        = number
  default     = 10
}


variable "vpc_id" {
  description = "VPC id. where the MSK cluster will be created."
  type        = string
  default     = null
}




variable "allowed_cidr_blocks" {
  description = "Allowed CIDR blocks."
  type        = list(string)
  default     = []

}


variable "users" {
  description = "MSK users."
  type        = list(string)
  default     = []

}



variable "region" {
  description = "AWS region."
  type        = string
  default     = null
}


variable "server_properties" {
  description = "Server properties."
  type        = string
  default     = null

}


variable "private_subnets" {
  description = "Private subnets."
  type        = list(string)
  default     = []
}

variable "default_num_partitions" {
  description = "Default number of partitions."
  type        = number
  default     = 3 * var.number_of_broker_nodes
}
