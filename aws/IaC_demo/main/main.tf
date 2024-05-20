# create resource AWS S3 bucket with terraform

provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-bucket-learning"
  tags = {
    Name = "terraform-learning"}
}

# Command to initialize the terraform: terraform init
# Command to create the resource: terraform apply