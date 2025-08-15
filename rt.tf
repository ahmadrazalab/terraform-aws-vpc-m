# Public Route Table with a route to the Internet Gateway. Associate it with the public subnets.
# Public Route Table: Associated with public subnets, contains a route to the IGW.

# Public Route Table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpcblock.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igwblock.id
  }
  tags = merge({
    Name = "${var.project}-${var.environment}-public-rt"
  }, var.tags)
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


# Create 3 private route tables, each using its own NAT gateway
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.vpcblock.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natblock[count.index].id
  }
  tags = merge({
    Name = "${var.project}-${var.environment}-private-rt-${element(["a","b","c"], count.index)}"
  }, var.tags)
}

# Associate each private subnet with its own route table
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
