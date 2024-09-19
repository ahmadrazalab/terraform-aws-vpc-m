# Using Terraform Cloud to manage terraform running using workspaces 
terraform { 
  cloud { 
    
    organization = "devops-aws-tf" 

    workspaces { 
      name = "vpc_module" 
    } 
  } 
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.64.0"
    }
  }
}

# Configure the AWS Provider cli with region hard code 
provider "aws" {
  region = "ap-south-1"
}
