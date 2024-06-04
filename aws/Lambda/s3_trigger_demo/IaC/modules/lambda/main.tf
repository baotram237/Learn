# Create lambda function
# official document: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

data "archive_file" "getObjectType" {
  type = "zip"
  source_file = "${path.module}/lambda/object_info.py"
  output_path = "object_info_lambda_function.zip"
}

resource "lambda_function" "object_info_function" {
  filename = data.getObjectType.output_path
  function_name = "get-object-info"
  role = aws_iam_role.s3_trigger_role.arn
  handler = "lambda.handler"
  runtime = "python 3.10"
  environment{
    variables = {
        AWS_PROFILE = trambao
    }
  }

}