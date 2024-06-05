Create IAM user using AWS CLI:
```bash
aws iam create-user --user-name <user-name>
```
Some resource: 
- https://docs.aws.amazon.com/lambda/latest/dg/python-handler.html
- Tutorial: https://docs.aws.amazon.com/lambda/latest/dg/with-s3-example.html
- boto3 - get_object: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3/client/get_object.html

1. Create a Lambda function 
2. Create a S3 bucket
3. Create a IAM role for Lambda function
4. Create a trigger for Lambda function
    -> Create aws_s3_bucket_notification and aws_lambda_permission resource
5. Upload a file to S3 bucket and check the Lambda function logs
