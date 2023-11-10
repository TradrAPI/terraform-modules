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
