# terraform-aws-vpc-m

A reusable Terraform module to provision a production-ready AWS VPC with public, private, and data subnets across multiple Availability Zones, including NAT Gateways, route tables, and tagging support.

## Features

- Creates a VPC with configurable CIDR block
- Supports multiple public, private, and data subnets (default: 3 AZs)
- Deploys Internet Gateway and NAT Gateways (one per AZ)
- Creates route tables and associations for public and private subnets
- Tags all resources with project, environment, and custom tags

## Usage

```hcl
module "vpc" {
  source = "./terraform-aws-vpc-m"

  aws_region            = "ap-south-1"
  vpc_cidr              = "10.10.0.0/16"
  public_subnet_cidrs   = ["10.10.0.0/20", "10.10.16.0/20", "10.10.32.0/20"]
  private_subnet_cidrs  = ["10.10.48.0/20", "10.10.64.0/20", "10.10.80.0/20"]
  data_subnet_cidrs     = ["10.10.96.0/20", "10.10.112.0/20", "10.10.128.0/20"]
  environment           = "dev"
  project               = "tracemypods"
  tags = {
    Owner      = "your-name"
    Department = "DevOps"
  }
}
```

## Inputs

| Name                  | Description                                         | Type         | Default                                         |
|-----------------------|-----------------------------------------------------|--------------|-------------------------------------------------|
| aws_region            | AWS region to deploy resources in                   | string       | `"ap-south-1"`                                  |
| vpc_cidr              | CIDR block for the VPC                              | string       | `"10.10.0.0/16"`                                |
| public_subnet_cidrs   | List of CIDRs for public subnets                    | list(string) | `["10.10.0.0/20", ...]`                         |
| private_subnet_cidrs  | List of CIDRs for private subnets                   | list(string) | `["10.10.48.0/20", ...]`                        |
| data_subnet_cidrs     | List of CIDRs for data subnets                      | list(string) | `["10.10.96.0/20", ...]`                        |
| environment           | Environment name (dev, staging, prod, etc.)         | string       | `"dev"`                                         |
| project               | Project name for tagging and resource naming        | string       | `"tracemypods"`                                 |
| tags                  | Additional tags to apply to all resources           | map(string)  | `{ "CreatedBy" = "Terraform" }`                 |

## Outputs

| Name                   | Description                                      |
|------------------------|--------------------------------------------------|
| vpc_id                 | The ID of the VPC                                |
| public_subnet_ids      | List of IDs of public subnets                    |
| private_subnet_ids     | List of IDs of private subnets                   |
| data_subnet_ids        | List of IDs of data subnets                      |
| nat_gateway_ids        | List of NAT Gateway IDs                          |
| public_route_table_id  | The ID of the public route table                 |
| private_route_table_ids| List of private route table IDs                  |

## Requirements

- Terraform >= 1.0
- AWS Provider >= 5.0

## Notes

- The module creates three subnets per type (public, private, data) by default, mapped to three AZs.
- Each private subnet gets its own NAT Gateway for high availability.
- Data subnets are intended for DBs or resources that do not require outbound internet access.

## License

MIT
