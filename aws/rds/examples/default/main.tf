provider "aws" {
  region = "us-west-2"
}

data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "db" {
  source = "../.."

  resources_prefix            = "test-db-instance"
  name                        = "testdb"
  instance_class              = "db.t3.micro"
  storage_type                = "gp2"
  engine                      = "postgres"
  engine_version              = "14.7"
  username                    = "testdbuser"
  password                    = "testdbpassword"
  allocated_storage           = 10
  max_allocated_storage       = 100
  manage_master_user_password = null
  final_snapshot_identifier   = "test-db-instance-final-snapshot"
  deletion_protection         = false

  tags = {
    Name = "Test DB instance"
  }

  vpc = {
    id      = data.aws_vpc.default.id
    cidr    = data.aws_vpc.default.cidr_block
    subnets = data.aws_subnets.default.ids
  }
}
