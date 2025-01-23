provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "us-west-2a"
}

module "instance" {
  source = "../.."

  vpc_id    = data.aws_vpc.default.id
  subnet_id = data.aws_subnet.default.id

  name             = "int-test-none-ore-ec2-0"
  resources_prefix = "test"
  az               = "us-west-2a"
  instance_type    = "t3.micro"
  private_ip       = cidrhost(data.aws_subnet.default.cidr_block, "20")
  root_volume_size = 20
  data_volume_size = 80
  ansible_group    = "testinstance"
  authorized_key   = file("files/testkey.pub")

  user_data_obj = {
    runcmd = [
      "echo 'Hello world!' > /tmp/hello.txt"
    ]
  }

  data_volume_tags = {
    Test-Tag = "Test-Value"
  }
}

output "connect" {
  value = "ssh -i files/testkey devops-admin@${module.instance.instance.public_ip}"
}
