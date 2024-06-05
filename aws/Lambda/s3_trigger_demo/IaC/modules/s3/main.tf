# Create S3 bucket
resource "aws_s3_bucket" "s3_demo_bucket" {
    bucket = "s3-demo-bucket"
}
output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.s3_demo_bucket.arn
}

output "aws_s3_bucket_id" {
  value = aws_s3_bucket.s3_demo_bucket.id
}