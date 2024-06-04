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

# local block to define values that are used in multiple places
locals {
    tags = {
        project = var.project
    }
    env_prefix = "dev"
    app_prefix = "demo"
    account_id = "000000000000"
}

// Terraform backend configuration
terraform {
  backend "s3" {
    bucket = "trambao-lab-s3-backend"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "trambao-lab-s3-backend-lock-state"
    encrypt = true
  }
}

module "dynamodb" {
  source = "../modules/dynamodb"
  providers = {
    aws = aws
  }
}

module "s3" {
  source = "../modules/s3"
  providers = {
    aws = aws
  }
}

output "s3_bucket" {
  value = module.s3.bucket_arn
}

output "dynamodb_table_arn" {
  value = module.dynamodb.dynamodb_table_arn
}

output "dynamodb_table_name" {
  value = module.dynamodb.dynamodb_table_name
}

data "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project}-s3-backend"
}

data "aws_dynamodb_table" "dynamodb_table" {
  name = "trambao-lab-s3-backend"
}

module "iam" {
  source = "../modules/iam"
  providers = {
    aws = aws
  }
  s3_bucket_arn = data.aws_s3_bucket.s3_bucket.arn
  dynamodb_table_arn = data.aws_dynamodb_table.dynamodb_table.arn
}