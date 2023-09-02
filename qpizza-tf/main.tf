terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
    source = "./networking"
}

module "secrets" {
  source = "./secrets"
}

module "database" {
  source = "./database"
  depends_on = [ module.networking, module.secrets ]
  vpc_id = module.networking.vpc_id
  subnet_ids = module.networking.private_subnet_ids
}
