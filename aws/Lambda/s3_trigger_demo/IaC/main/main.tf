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
  iam_role_arn = module.iam.s3_trigger_role_arn
}

module "trigger" {
  source = "../modules/trigger"
  aws_s3_bucket_id = module.s3.aws_s3_bucket_id
  aws_s3_bucket_arn = module.s3.aws_s3_bucket_arn
  aws_lambda_function_arn = module.lambda.aws_lambda_function_arn
}