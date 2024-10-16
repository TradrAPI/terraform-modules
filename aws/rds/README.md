# aws/rds module

Allows the provisioning of DB instances.

## Required variables

- `name` - DB name
- `username` - DB user name
- `password` - DB user password
- `resources_prefix` - resources will be created with this prefix
- `vpc` - VPC object
  - `id` - VPC id
  - `private_subnets` - list of the VPC private subnets
  - `cidr` - VPC ip range as cidr block notation

## Optional variables

- `allocated_storage` - Allocated DB storage in GiB.
- `instance_class` - DB instance class. See https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html
- `tags` - DB tags
- `skip_final_snapshot` - Whether to take a DB snapshot before deleting the instance
- `storage_type` - DB storage type
- `storage_encrypted` - DB storage encryption enabled
- `iops` - DB IOPS
- `storage_throughput` - DB storage throughput
- `engine` - DB engine
- `engine_version` - DB engine version
- `backup_retention_period` - Number of days to keep DB backups
- `snapshot_identifier` - Specify a snapshot to create the DB instance from. Triggers recreation
- `final_snapshot_identifier` - If `skip_final_snapshot = false`, takes a snapshot with this name before deleting the DB instance. Only takes effect it `skip_final_snapshot` is set to `false` during DB creation
- `deletion_protection` - Whether to allow the DB instance to be deleted
- `ca_cert_identifier` - RDS certificate authority identifier

## Scope of this module

`aws_db_subnet_group`

`aws_db_instance`

`aws_security_group`

`aws_security_group_rule`

## Examples

```terraform
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

module "db" {
  source = "../.."

  resources_prefix    = "test-db-instance"
  name                = "testdbinstance"
  instance_class      = "db.t2.micro"
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "11.6"
  username            = "testdbuser"
  password            = "testdbpassword"
  allocated_storage   = 10
  skip_final_snapshot = true

  tags = {
    Name = "Test DB instance"
  }

  vpc = {
    id      = data.aws_vpc.default.id
    cidr    = data.aws_vpc.default.cidr_block
    subnets = data.aws_subnet_ids.default.ids
  }
}
```

## Outputs

- `this` - The `aws_db_instance` output for the db instance. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#attributes-reference .
- `sg` - The `aws_security_group` output for the db security group. See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group .
