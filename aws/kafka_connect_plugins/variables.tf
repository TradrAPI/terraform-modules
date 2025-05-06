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
    alias = optional(string, "")
    urls  = list(string)
  }))

  default = {}

  validation {
    condition = alltrue(flatten([
      for _, urls in var.plugins : [
        for url in urls :
        contains(["zip", "jar"], split(".", url)[length(split(".", url)) - 1])
      ]
    ]))

    error_message = "All plugins must be zip files"
  }
}
