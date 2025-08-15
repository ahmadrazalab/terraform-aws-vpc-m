

output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.vpcblock.id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets."
  value       = aws_subnet.private[*].id
}

output "data_subnet_ids" {
  description = "List of IDs of data subnets."
  value       = aws_subnet.data[*].id
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs (one per public subnet)."
  value       = aws_nat_gateway.natblock[*].id
}

output "public_route_table_id" {
  description = "The ID of the public route table."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "List of private route table IDs (one per private subnet)."
  value       = aws_route_table.private[*].id
}
