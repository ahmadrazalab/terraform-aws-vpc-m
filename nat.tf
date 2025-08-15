#NAT Gateway or NAT Instance: For instances in private subnets that need to access the internet for updates, a NAT Gateway is needed. This NAT Gateway is usually placed in one of the public subnets.
# Create a NAT Gateway in one of the public subnets.

# Create NAT Gateway in a Public Subnet


# Create 3 EIPs for 3 NAT Gateways
resource "aws_eip" "nat" {
  count = length(var.public_subnet_cidrs)
  domain = "vpc"
  tags = merge({
    Name = "${var.project}-${var.environment}-nat-eip-${element(["a","b","c"], count.index)}"
  }, var.tags)
}

# Create 3 NAT Gateways, one per public subnet
resource "aws_nat_gateway" "natblock" {
  count         = length(var.public_subnet_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = merge({
    Name = "${var.project}-${var.environment}-nat-gateway-${element(["a","b","c"], count.index)}"
  }, var.tags)
}
