provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "default" {
  default = true
}

module "instance" {
  source = "../.."

  vpc_id = data.aws_vpc.default.id

  resources_prefix   = "test-instance"
  ssh_trusted_cidrs  = ["0.0.0.0/0"]
  http_trusted_cidrs = ["0.0.0.0/0"]

  name                        = "test-instance"
  type                        = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Environment = "Testing"
  }

  key_pair = {
    name       = "test-instance"
    public_key = file("files/testkey.pub")
  }

  ami_filter = {
    owner = "amazon"
    name  = "amzn2-ami-hvm-2.0.20211001.1-x86_64-gp2"
  }
}

output "this" {
  value = module.instance
}
