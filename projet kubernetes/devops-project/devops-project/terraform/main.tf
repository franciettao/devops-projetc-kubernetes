# terraform/main.tf
terraform {
  cloud {
    organization = "your-terraform-cloud-organization-name"
    workspaces {
      name = "learn-terraform-"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-2"
}

module "learn_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "learn-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Name = "learn-vpc"
  }
}

module "web_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"

  name        = "web-sg"
  description = "SecuritySources: [developer.hashicorp.com](https://developer.hashicorp.com/terraform/cli/commands/fmt) (1) [developer.hashicorp.com](https://developer.hashicorp.com/terraform/tutorials/configuration-language/move-config) (2) [squadcast.com](https://www.squadcast.com/blog/creating-your-first-module-using-terraform) (3) [blog.gruntwork.io](https://blog.gruntwork.io/how-to-create-reusable-infrastructure-with-terraform-modules-25526d65f73d) (4) 

 Here is the code for terraform/main.tf with the changes you requested:

```hcl
terra group for web servers"
  vpc_id      = module.learn_vpc.vpc_id

 form {
  cloud {
    organization = "your-terraform-cloud ingress_with_cidr_blocks = [
    {
      from_port   =-organization-name"
    workspaces {
      name = "learn-terraform- 8080
      to_port     = 808"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-2"
}

module "learn_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "learn-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Name = "learn-vpc"
  }
}

module "web_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.13.0"

  name        = "web-sg"
  description = "Security group for web servers"
  vpc_id      = module.learn_vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "ec2_instance" {
  source         = "./modules/compute"
  security_group = module.web_security_group.security_group_id
  public_subnets = module.learn_vpc.public_subnets

  instance_type = "t2.micro"
}

moved {
  from = module.vpc
  to   = module.learn_vpc
}