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

output "private_route_tables_v2" {
  description = "List of private route tables v2"
  value       = aws_route_table.private_v2
}

output "private_routes_v2" {
  value = concat(
    aws_route.private_nat_v2,
    values(aws_route.private_v2),
  )
}

output "public_route_tables" {
  description = "List of public route tables"
  value       = aws_route_table.public
}

output "public_route_tables_v2" {
  description = "List of public route tables v2"
  value       = aws_route_table.public_v2
}

output "public_routes_v2" {
  value = concat(aws_route.public_gateway_v2, values(aws_route.public_v2))
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
