variable "name" {
  description = "DB name."
  type        = string
  default     = null
}

variable "username" {
  description = "DB user name."
  type        = string
}

variable "password" {
  type      = string
  sensitive = true
  nullable  = true
  default   = null
}

variable "resources_prefix" {
  description = "Creates resources with this prefix."
  type        = string
}

variable "vpc" {
  type = object({
    id      = string
    cidr    = string
    subnets = list(string)
  })
}

variable "allocated_storage" {
  description = "Allocated DB storage in GiB."
  type        = number
  default     = 10
}

variable "instance_class" {
  # See https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
  description = "DB instance class."
  type        = string
  default     = "db.t2.micro"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "storage_type" {
  type    = string
  default = "gp2"
}

variable "engine" {
  type    = string
  default = "postgres"
}

variable "engine_version" {
  type    = string
  default = "11.6"
}

variable "backup_retention_period" {
  description = "Backup retention period in days."
  type        = number
  default     = 30
}

variable "snapshot_identifier" {
  description = "Specify a snapshot to create the DB instance from. Triggers recreation."
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  # Only takes effect if skip_final_snapshot is set to false during creation.
  description = "If skip_final_snapshot = false, takes a snapshot with this name before deleting the instance."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "The database can't be deleted when this is set to true."
  type        = bool
  default     = false
}

variable "apply_immediately" {
  type    = bool
  default = false
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "parameter_group" {
  type    = string
  default = null
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "enabled_cloudwatch_logs_exports" {
  type = list(string)

  default = []
}

# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#managed-master-passwords-via-secrets-manager-default-kms-key
variable "manage_master_user_password" {
  type    = bool
  default = false
}

variable "blue_green_update_enabled" {
  type    = bool
  default = false
}

variable "monitoring_interval" {
  type    = number
  default = 15
}

variable "monitoring_role" {
  type    = string
  default = "rds-monitoring-role"
}

variable "create_monitoring_role" {
  type    = bool
  default = false
}

variable "max_allocated_storage_factor" {
  type    = number
  default = 2 # by deafult twice the amount of disk for the db instance
}
