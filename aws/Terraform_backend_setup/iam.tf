# iam.tf file to create IAM resources and some configurations
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity

# data source aws_caller_identity to get the ARN of the current user

data "aws_caller_identity" "current" {
}

locals {
  principal_arns = var.principal_arn != null ? var.principal_arn : [data.aws_caller_identity.current.arn]
}

# policy document to define the permissions of the IAM policy
# create a policy document with the required permissions 
# -> Create iam_policy and iam_role resources
# -> Attach the policy to the role
data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions = ["s3:ListBucket"]
    resources = [aws_s3_bucket.s3_bucket.arn]
  }
  statement {
    actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]
  }
  statement {
    actions = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem", "dynamodb:UpdateItem"]
    resources = [aws_dynamodb_table.dynamodb_table.arn]
  }
}

# Create iam_policy and iam_role resources
resource "aws_iam_policy" "policy" {
  name = "${var.project}-S3-Backend-Policy"
  path = "/"
  policy = data.aws_iam_policy_document.policy_doc.json
}

resource "aws_iam_role" "iam_role" {
  name = "${var.project}-S3-Backend-Role"
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
        "AWS": ${jsonencode(local.principal_arns)}
      },
      "Effect": "Allow"
      }
    ]
  }
  EOF
    tags = local.tags
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "policy_attach" {
  role = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.policy.arn
}