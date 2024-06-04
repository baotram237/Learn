terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" 
    }
  }
}

provider "aws" {
  region = var.region
}

module "iam" {
  source = "../modules/iam"
}

module "s3" {
  source = "../modules/s3"
}

module "lambda" {
  source = "../modules/lambda"
}