# main Terraform file
provider "aws" {
  region                      = var.region
}

# local block to define values that are used in multiple places
locals {
  tags = {
    project = var.project
  }
}

data "aws_region" "current" {
}

output "config" {
  value = {
    bucket = aws_s3_bucket.s3_bucket.bucket
    region = data.aws_region.current.name
    role_arn = aws_iam_role.iam_role.arn
    dynamodb_table = aws_dynamodb_table.dynamodb_table.name
  }
}