output "this" {
  value = aws_instance.this
}

output "eip" {
  value = try(aws_eip.this[0], null)
}

output "ebs" {
  value = aws_ebs_volume.this
}

output "sg" {
  value = aws_security_group.this
}
