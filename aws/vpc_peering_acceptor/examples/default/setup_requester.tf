module "requester_network" {
  source = "../.."

  az_zones = local.az_zones
  region   = local.region
  vpc_sub  = local.requester_cidr.short

  name           = "tst-peering-accepter-module-requester"
  deployment_env = "tst"

  extra_private_routes = [{
    cidr_block                = local.accepter_cidr.full
    vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  }]

  extra_public_routes = [{
    cidr_block                = local.accepter_cidr.full
    vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  }]
}

resource "aws_vpc_peering_connection" "requester" {
  vpc_id = module.requester_network.vpc_id

  peer_vpc_id   = module.accepter_network.vpc_id
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_region   = local.region

}

resource "aws_vpc_peering_connection_options" "requester" {
  count = var.set_req_options ? 1 : 0

  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

module "requester_instance" {
  source = "../.."

  vpc_id            = module.requester_network.vpc_id
  subnet_id         = module.requester_network.public_subnets[0]
  availability_zone = local.az_zones[0]

  resources_prefix   = "tst-peering-requester-instance"
  ssh_trusted_cidrs  = ["0.0.0.0/0"]
  http_trusted_cidrs = ["0.0.0.0/0"]

  name                        = "tst-peering-requester-instance"
  type                        = "t2.micro"
  associate_public_ip_address = true
  root_volume_size            = 20
  root_volume_type            = "gp2"

  tags = {
    Environment = "Testing"
    Side        = "Requester"
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

resource "aws_security_group_rule" "allow_peer_ingress" {
  security_group_id = module.requester_instance.sg.id
  description       = "Allow all ingress from req VPC"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  type              = "ingress"
  cidr_blocks       = [local.accepter_cidr.full]
}