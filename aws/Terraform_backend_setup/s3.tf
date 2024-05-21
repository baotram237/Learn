# s3.tf to create S3 bucket and some configurations
# 1. Create an S3 bucket
# 2. Define Access Control List (ACL) for the S3 bucket
# 3. Enable versioning for the S3 bucket
# 4. Create a KMS key
# 5. Define server-side encryption configuration for the S3 bucket


resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.project}-s3-backend"
  force_destroy = false
  tags   = local.tags
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl = "private"
}

resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "kms_key" {
  tags = local.tags
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