resource "aws_s3_bucket" "data_bucket" {
  bucket = "glue-demo-bucket"
}

output "aws_s3_bucket_arn" {
  value = aws_s3_bucket.data_bucket.arn
}