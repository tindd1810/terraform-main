terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "tindd-terraform-state-prod"
    key    = "services/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "services" {
  source = "git@github.com:tindd1810/modules.git//services"
  # alb-name = "hoangdl-alb-testing"
  # target-group-name = "hoangdl-tg-testing"
  # lambda-function-name = "hoangdl"
  # env = "testing"
  bucket = "tindd-terraform-state-prod"
}

output "vpc-id" {
  value = module.services.vpc-id
}
output "ec2-ip0" {
  value = module.services.ec2-ip0
}
output "ec2-ip1" {
  value = module.services.ec2-ip1
}
