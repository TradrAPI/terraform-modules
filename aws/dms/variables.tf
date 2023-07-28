variable "subnet_group" {
  type = object({
    id         = string
    subnet_ids = list(string)
  })
}

variable "replication_instance" {
  type = object({
    name              = string
    class             = string
    allocated_storage = number

    vpc_security_group_ids       = optional(list(string), [])
    availability_zone            = optional(string)
    engine_version               = optional(string)
    preferred_maintenance_window = optional(string, "sun:10:30-sun:14:30")
    multi_az                     = optional(bool, false)
  })
}

variable "sources" {
  type = map(object({
    name        = string
    endpoint_id = string
    engine_name = string
    username    = string
    password    = string
    server_name = string
    port        = number

    database_name               = optional(string)
    ssl_mode                    = optional(string, "none")
    extra_connection_attributes = optional(string, "")
  }))

  default = {}
}

variable "targets" {
  type = map(object({
    name        = string
    endpoint_id = string
    engine_name = string
    username    = string
    password    = string
    server_name = string
    port        = number

    database_name               = optional(string)
    ssl_mode                    = optional(string, "none")
    extra_connection_attributes = optional(string, "")
  }))

  default = {}
}

variable "replication_tasks" {
  type = map(object({
    name                      = string
    replication_task_id       = string
    source_endpoint           = string
    target_endpoint           = string
    table_mappings            = string
    replication_task_settings = optional(string)
    migration_type            = optional(string, "full-load-and-cdc")
  }))
}
