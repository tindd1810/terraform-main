terraform {
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket = "tindd-terraform-state-prod"
    key    = "jenkins-node/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

module "jenkins-node" {
  source = "git@github.com:tindd1810/modules.git//jenkins-node"
  bucket = "tindd-terraform-state-prod"
}

output "vpc-id" {
  value = module.jenkins-node.vpc-id
}
output "agent-ip" {
  value = module.jenkins-node.agent-ip
}