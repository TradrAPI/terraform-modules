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
| name | Name of Redis Cluster | `string` | n/a | yes |
| nodes | number of nodes for redis cluster | `number` | n/a | yes |
| platform | Name of Platform or Brand | `string` | n/a | yes |
| port | port number for redis | `number` | n/a | yes |
| subnet | List of subnets ID For Redis subnet | `list(string)` | n/a | yes |
| vpc | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
| security\_id | n/a |