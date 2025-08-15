
# Public Subnets

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.vpcblock.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    var.tags,
    {
      "Type" = "Public",
      "Name" = "${var.project}-${var.environment}-public-subnet-${element(["a","b","c"], count.index)}"
    }
  )
}

# Private Subnets

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpcblock.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    var.tags,
    {
      "Type" = "Private",
      "Name" = "${var.project}-${var.environment}-private-subnet-${element(["a","b","c"], count.index)}"
    }
  )
}

# Data Subnets (no NAT, DB-only access)

resource "aws_subnet" "data" {
  count             = length(var.data_subnet_cidrs)
  vpc_id            = aws_vpc.vpcblock.id
  cidr_block        = var.data_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    var.tags,
    {
      "Type" = "Data",
      "Name" = "${var.project}-${var.environment}-data-subnet-${element(["a","b","c"], count.index)}"
    }
  )
}