## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dlq | queue with dead letter queue | `bool` | n/a | yes |
| env | enviroment | `string` | n/a | yes |
| name | Name of queue | `string` | n/a | yes |
| platform | Name of Platform or Brand | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| log\_url | n/a |
| url | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sqs_queue.dlq_for_fifo_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.dlq_for_standard_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.fifo_queue_with_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.fifo_queue_without_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.standard_queue_with_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.standard_queue_without_dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dlq"></a> [dlq](#input\_dlq) | queue with dead letter queue | `bool` | n/a | yes |
| <a name="input_fifo"></a> [fifo](#input\_fifo) | FIFO queue or not | `bool` | `false` | no |
| <a name="input_max_message_size"></a> [max\_message\_size](#input\_max\_message\_size) | n/a | `string` | `"262144"` | no |
| <a name="input_message_retention_seconds"></a> [message\_retention\_seconds](#input\_message\_retention\_seconds) | n/a | `string` | `"345600"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of queue | `string` | n/a | yes |
| <a name="input_platform"></a> [platform](#input\_platform) | the platform the queue is for | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sqs"></a> [sqs](#output\_sqs) | n/a |
| <a name="output_sqs-dlq"></a> [sqs-dlq](#output\_sqs-dlq) | n/a |
<!-- END_TF_DOCS -->