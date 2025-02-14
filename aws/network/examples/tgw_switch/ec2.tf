module "instance" {
  source = "../../../ec2"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.private_subnets[0]

  resources_prefix = "test-instance"

  name                        = "test-instance"
  type                        = "t2.micro"
  root_volume_size            = 20
  root_volume_type            = "gp2"
  associate_public_ip_address = false
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
        tls_private_key.ssh.public_key_openssh
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
    name  = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"
  }
}

resource "local_file" "ssh_key" {
  filename = "testkey"
  content  = tls_private_key.ssh.private_key_pem
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_security_group_rule" "ingress_8080" {
  security_group_id = module.instance.sg.id

  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
}
