# Create VPC

variable "aws_region" {
  description = "AWS region to deploy resources in."
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}


variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
  default     = [
    "10.10.0.0/20",   # public-subnet-a
    "10.10.16.0/20",  # public-subnet-b
    "10.10.32.0/20"   # public-subnet-c
  ]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
  default     = [
    "10.10.48.0/20",  # private-subnet-a
    "10.10.64.0/20",  # private-subnet-b
    "10.10.80.0/20"   # private-subnet-c
  ]
}

variable "data_subnet_cidrs" {
  description = "List of CIDR blocks for data subnets (no NAT, DB-only access)."
  type        = list(string)
  default     = [
    "10.10.96.0/20",   # data-subnet-a
    "10.10.112.0/20",  # data-subnet-b
    "10.10.128.0/20"   # data-subnet-c
  ]
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name for tagging and resource naming."
  type        = string
  default     = "tracemypods"
}

## add default prod level tags 
variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {
    "CreatedBy" = "Terraform",
  
  }
}
