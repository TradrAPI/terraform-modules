output "eip" {
  value = try(aws_eip.this[0], null)
}

output "instance" {
  value = aws_instance.this
}

output "sg" {
  value = aws_security_group.this
}

output "ebs" {
  value = try(aws_ebs_volume.this[0], null)
}
