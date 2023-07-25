output "connect_requester" {
  value = "ssh -i files/testkey devops-admin@${module.requester_instance.this.public_ip}"
}

output "requester_private_ip" {
  value = module.requester_instance.this.private_ip
}

output "connect_accepter" {
  value = "ssh -i files/testkey devops-admin@${module.accepter_instance.this.public_ip}"
}

output "accepter_private_ip" {
  value = module.accepter_instance.this.private_ip
}