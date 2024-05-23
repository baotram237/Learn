terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0" 
    }
  }
}

# Create AWS S3 bucket to store terraform state
# 1. Create S3 bucket
# 2. Enable versioning
# 3. Enable server-side encryption
# 4. Enable ACL

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project}-s3-backend"
  force_destroy = false
}

resource "aws_s3_bucket_acl" "aws_s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl = "private"
}

resource "aws_s3_bucket_versioning" "aws_s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "kms_key" {
  description = "KMS key for TF backend"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
        apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kms_key.arn
        sse_algorithm     = "aws:kms"
        }
    }
}

output "bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}