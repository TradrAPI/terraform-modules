provider "aws" {
  region = "us-west-2"
}

data "aws_vpc" "default" {
  default = true
}

module "instance" {
  source = "../.."

  vpc_id = data.aws_vpc.default.id

  resources_prefix = "test-instance"

  name                        = "test-instance"
  type                        = "t2.micro"
  root_volume_size            = 20
  root_volume_type            = "gp2"
  associate_public_ip_address = true
  ssh_trusted_cidrs           = ["0.0.0.0/0"]

  user_data_obj = {
    package_update = true
    packages       = ["coreutils"]

    users = [{
      name   = "devops-admin"
      groups = "sudo"
      shell  = "/bin/bash"
      sudo   = "ALL=(ALL) NOPASSWD:ALL"

      ssh_authorized_keys = [
        file("files/testkey.pub")
      ]
    }]

    runcmd = [
      "echo 'Hello, World' > index.html",
      "nohup busybox httpd -f -p 8080 &",
    ]
  }

  tags = {
    Environment = "Testing"
  }

  ami_filter = {
    owner = "099720109477" # canonical
    name  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211129"
  }
}

resource "aws_security_group_rule" "ingress_8080" {
  security_group_id = module.instance.sg.id

  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}

output "connect" {
  value = "ssh -i files/testkey devops-admin@${module.instance.this.public_ip}"
}

output "curl" {
  value = "curl ${module.instance.this.public_ip}:8080"
}
