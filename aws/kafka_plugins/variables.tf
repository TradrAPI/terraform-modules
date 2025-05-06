variable "bucket_name" {
  description = "Name of the bucket to store plugins"
  type        = string
  default     = ""
}

variable "create_bucket" {
  description = "Whether to create the plugins bucket"
  type        = bool
  default     = true
}

variable "plugins" {
  description = "Map of plugins names to configs"

  type = map(object({
    url   = string
    alias = optional(string, "")
  }))

  default = {}

  validation {
    condition     = alltrue([for _, url in var.plugins : split(url, ".")[-1] == "zip"])
    error_message = "All plugins must be zip files"
  }
}
