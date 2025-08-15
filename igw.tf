# Create Internet Gateway

resource "aws_internet_gateway" "igwblock" {
  vpc_id = aws_vpc.vpcblock.id
  tags = merge({
    Name = "${var.project}-${var.environment}-igw"
  }, var.tags)
}

variable "vpc_tags" {
  description = "A map of tags to assign to the VPC and related resources"
  type        = map(string)
  default     = {}
}