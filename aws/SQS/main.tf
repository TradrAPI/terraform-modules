terraform {
  required_version = ">= 1.0.0"
}

resource "aws_sqs_queue" "dlq_for_standard_queue" {
  count = var.dlq == true && var.fifo == false ? 1 : 0
  name                      = "DLQ-${var.platform}-${var.name}"
  delay_seconds             = 0
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = 0
}

resource "aws_sqs_queue" "standard_queue_with_dlq" {
  count = var.dlq == true && var.fifo == false ? 1 : 0
  name                      = "${var.platform}-${var.name}"
  delay_seconds             = 0
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = 0
  redrive_policy = jsonencode({
    deadLetterTargetArn = element(aws_sqs_queue.dlq_for_standard_queue.*.arn, count.index)
    maxReceiveCount     = 10
  })
}

resource "aws_sqs_queue" "standard_queue_without_dlq" {
  count = var.dlq == false && var.fifo == false ? 1 : 0
  name                      = "${var.platform}-${var.name}"
  delay_seconds             = 0
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = 0
}

resource "aws_sqs_queue" "dlq_for_fifo_queue" {
  count                     = var.fifo && var.dlq == true ? 1 : 0
  name                      = "DLQ-${var.platform}-${var.name}.fifo"
  fifo_queue                = var.fifo
  delay_seconds             = 0
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = 0
  content_based_deduplication = true
}

resource "aws_sqs_queue" "fifo_queue_with_dlq" {
  count                     = var.fifo && var.dlq == true ? 1 : 0
  name                      = "${var.platform}-${var.name}.fifo"
  fifo_queue                = var.fifo
  delay_seconds             = 0
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = 0
  content_based_deduplication = true
  redrive_policy = jsonencode({
    deadLetterTargetArn = element(aws_sqs_queue.dlq_for_fifo_queue.*.arn, count.index)
    maxReceiveCount     = 10
  })
}

resource "aws_sqs_queue" "fifo_queue_without_dlq" {
  count                     = var.fifo == true && var.dlq == false ? 1 : 0
  name                      = "${var.platform}-${var.name}.fifo"
  fifo_queue                = var.fifo
  delay_seconds             = 0
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  receive_wait_time_seconds = 0
  content_based_deduplication = true
}