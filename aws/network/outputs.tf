output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "private_route_tables" {
  description = "List of private route tables"
  value       = aws_route_table.private
}

output "private_routes" {
  value = concat(
    aws_route.private_nat,
    values(aws_route.private),
  )
}

output "public_route_tables" {
  description = "List of public route tables"
  value       = aws_route_table.public
}

output "public_routes" {
  value = concat(aws_route.public_gateway, values(aws_route.public))
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.default.*.id, [""])[0]
}

output "vpc" {
  description = "The ID of the VPC"
  value       = aws_vpc.default
}

output "nat_gateways" {
  description = "List of nat gateways"
  value       = concat(aws_eip.nat.*)
}
