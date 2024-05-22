# create resource AWS S3 bucket with terraform
  # authentication details for localstacl
provider "aws" {
  region = "us-west-1"
  access_key = "test"
  secret_key = "test"
  s3_use_path_style = true
  skip_credentials_validation = true
  skip_metadata_api_check = true
  skip_requesting_account_id = true

  endpoints {
    s3 = "http://s3.localhost.localstack.cloud:4566"
  
  }
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-bucket-learning"
  tags = {
    Name = "terraform-learning"}
}

resource "aws_s3_bucket" "terraform-bucket-2" {
  bucket = "terraform-bucket-learning-${var.MY_SECOND_VARIABLE}"
}
# Command to initialize the terraform: terraform init
# Command to create the resource: terraform apply