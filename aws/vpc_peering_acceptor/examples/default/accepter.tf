module "accepter_network" {
  source = "../.."

  region   = local.region
  az_zones = local.az_zones
  vpc_sub  = local.accepter_cidr.short

  name           = "tst-peering-accepter-module-accepter"
  deployment_env = "tst"

  extra_public_routes  = module.accepter.routes_back_to_requester_vpc
  extra_private_routes = module.accepter.routes_back_to_requester_vpc
}

module "accepter" {
  source = "../.."

  peering_conn_id = aws_vpc_peering_connection.requester.id
  requester_cidr  = local.requester_cidr.full

  name = "tst-peering"

  allow_remote_vpc_dns_resolution = true

  sg_id = module.accepter_instance.sg.id

  sg_rules = [{
    description = "Allow all ingress from req VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    type        = "ingress"
  }]
}

module "accepter_instance" {
  source = "../.."

  vpc_id            = module.accepter_network.vpc_id
  subnet_id         = module.accepter_network.public_subnets[0]
  availability_zone = local.az_zones[0]

  resources_prefix   = "tst-peering-accepter-instance"
  ssh_trusted_cidrs  = ["0.0.0.0/0"]
  http_trusted_cidrs = ["0.0.0.0/0"]

  name                        = "tst-peering-accepter-instance"
  type                        = "t2.micro"
  associate_public_ip_address = true
  root_volume_size            = 20
  root_volume_type            = "gp2"

  tags = {
    Environment = "Testing"
    Side        = "Accepter"
  }

  ami_filter = {
    owner = "099720109477"
    name  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20211129"
  }

  user_data_obj = {
    users = [{
      name   = "devops-admin"
      groups = "sudo"
      shell  = "/bin/bash"
      sudo   = "ALL=(ALL) NOPASSWD:ALL"

      ssh_authorized_keys = [
        file("./files/testkey.pub")
      ]
    }]
  }
}
