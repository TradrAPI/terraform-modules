variable "name" {
    type = string
    description = "Name of queue"
}
variable "dlq"{
    type = bool
    description = "queue with dead letter queue"
}

variable "fifo" {
    type = bool
    description = "FIFO queue or not"
    default = false
}

variable "platform" {
    type = string
    description = "the platform the queue is for"
}

variable "max_message_size" {
  type = string
  default = "262144"
}

variable "message_retention_seconds" {
  type = string
  default = "345600"
}
