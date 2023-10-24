output "sqs-dlq" {
    value = var.dlq ? ( var.fifo ? aws_sqs_queue.dlq_for_fifo_queue[0].id : aws_sqs_queue.dlq_for_standard_queue[0].id ) : null
}

output "sqs" {
    value = var.fifo ? ( var.dlq ? aws_sqs_queue.fifo_queue_with_dlq[0].id : aws_sqs_queue.fifo_queue_without_dlq[0].id )  : ( var.dlq ? aws_sqs_queue.standard_queue_with_dlq[0].id : aws_sqs_queue.standard_queue_without_dlq[0].id )
}