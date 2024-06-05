# Create lambda function
# official document: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

# archive source code
# creete aws_lambda_function

data "archive_file" "lambda_demo" {
  type = "zip"
  source_file = "${path.module}/object_info.py"
  output_path = "lambda_demo.zip"
}

resource "aws_lambda_function" "lambda_demo" {
  filename = "lambda_demo.zip"
  function_name = "lambda_trigger_s3"
  role = var.iam_role_arn
  source_code_hash = data.archive_file.lambda_demo.output_base64sha256
  runtime = "python3.10"
  handler ="lambda_function.lambda_handler"
}

output "aws_lambda_function_arn" {
  value = aws_lambda_function.lambda_demo.arn
}