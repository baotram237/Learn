# 1. aws_lambda_permission resource:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
# -> Gives an external source (like an EventBridge Rule, SNS, or S3) permission to access the Lambda function.

# 2. Create S3 bucket notification ~ it will create notification when an Object was uploaded to S3 bucket
# Doc: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification

# Other references: 
    # https://docs.aws.amazon.com/AmazonS3/latest/userguide/EventNotifications.html
    # S3 notification 
    # https://docs.aws.amazon.com/AmazonS3/latest/userguide/how-to-enable-disable-notification-intro.html

# aws_lambda_permission
resource "aws_lambda_permission" "allow_bucket" {
  statement_id = "AllowExecutionFromS3Bucket"
  action = "lambda:InvokeFunction"
  function_name = var.aws_lambda_function_arn
  principal = "s3.amazonaws.com"
  source_arn = var.aws_s3_bucket_arn
}

# aws_s3_bucket_notification
resource "aws_s3_bucket_notification" "s3_bucket_notification" {
  bucket = var.aws_s3_bucket_id
  lambda_function {
    lambda_function_arn = var.aws_lambda_function_arn
    events = [ "s3:ObjectCreated:*" ]
  }
}
