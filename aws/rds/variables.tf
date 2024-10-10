variable "source_db_instance_id" {
  description = "Source DB instance ID for replication. If null, creates main DB."
  type        = string
  default     = null
}

variable "resources_prefix" {
  description = "Prefix for resource names."
  type        = string
}

variable "name" {
  description = "Name of the DB."
  type        = string
}

variable "instance_class" {
  description = "Instance class for the primary DB."
  type        = string
}

# variable "instance_class_replica" {
#   description = "Instance class for the replica DB."
#   type        = string
#   default     = null
# }

variable "storage_type" {
  description = "Storage type for the DB."
  type        = string
}

variable "engine" {
  description = "Database engine."
  type        = string
}

variable "engine_version" {
  description = "Version of the database engine."
  type        = string
}

variable "username" {
  description = "Username for the DB."
  type        = string
}

variable "password" {
  description = "Password for the DB."
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage for the DB."
  type        = number
}

variable "final_snapshot_identifier" {
  description = "Identifier for the final snapshot."
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection."
  type        = bool
  default     = false
}

variable "create_monitoring_role" {
  description = "Create a monitoring role."
  type        = bool
  default     = true
}

variable "monitoring_role" {
  description = "ARN of the monitoring role."
  type        = string
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment."
  type        = bool
  default     = false
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage."
  type        = number
}

variable "vpc" {
  type = object({
    id      = string
    cidr    = string
    subnets = optional(list(string), [])
  })
}

variable "tags" {
  description = "Tags for the DB."
  type        = map(string)
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights."
  type        = bool
  default     = false
}

variable "manage_master_user_password" {
  description = "Manage the master user password."
  type        = string
  default     = null
}

variable "snapshot_identifier" {
  description = "Snapshot identifier for restoring."
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Enable storage encryption."
  type        = bool
  default     = true
}

variable "iops" {
  description = "Provisioned IOPS."
  type        = number
  default     = null
}

variable "storage_throughput" {
  description = "Storage throughput."
  type        = number
  default     = null
}

variable "backup_retention_period" {
  description = "Backup retention period."
  type        = number
  default     = 7
}

variable "apply_immediately" {
  description = "Apply changes immediately."
  type        = bool
  default     = true
}

variable "monitoring_interval" {
   description = "Monitoring interval"
  type        = number
  default     = "30"
}

variable "publicly_accessible" {
  description = "Is the instwance accessible from public"
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  description = "CloudWatch logs to export."
  type        = list(string)
  default     = []
}

variable "ca_cert_identifier" {
  description = "CA certificate identifier."
  type        = string
  default     = null
}

variable "replica_statement_timeout" {
  description = "Statement timeout for replica."
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "parameter_group" {
  description = "Parameter group name"
  type        = string
}

variable "family" {
  description = "Parameter group family"
  type        = string
}

variable "replicate_source_db" {
  description = "main db "
  type        = string 
  default     = null
}

variable "availability_zone" {
  description = "Region's availiability zone"
  type        = string 
  default     = null
}

variable "maintenance_window" {
  description = "Date time range allowing maintenance"
  type = string
  default = null
}

variable "performance_insights_retention_period" {
  description = "Specify how much indays you need insights to hold data on. has to be multiple of 31"
  type = number
  default = 31
}


variable "logical_replication" {
  description = "Enable logical replication TODO"
  type = bool
  default = true
}