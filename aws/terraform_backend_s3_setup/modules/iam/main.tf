# IAM modules 
# Reference: https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest

# # create IAM user and IAM group in AWS CLI
# aws iam create-user --user-name tramntb_de
# aws iam create-user --group-name tramntb_da

# # add access key to the user
# aws iam create-access-key --user-name tramntb_de
# aws iam create-access-key --user-name tramntb_de

# # create group
# aws iam create-group --group-name da_user
# aws iam create-group --group-name de_user

# # add user to groups
# aws iam add-user-to-group --user-name tramntb_de --group-name da_user
terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0" 
    }
  }
}
# Create policy using Terraform
# Reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
# 1. Create policy document to define the permissions of the IAM policy
# 2. Create iam_policy and iam_role resources
# 3. Attach the policy to the role

# 1. policy document 
data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions = ["s3:ListBucket"]
    resources = [var.s3_bucket_arn]
  }
  statement {
    actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${var.s3_bucket_arn}/*"]
  }
  statement {
    actions = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:DeleteItem", "dynamodb:UpdateItem"]
    resources = [var.dynamodb_table_arn]
  }
}

# 2. Create iam_policy and iam_role resources: s3_backend_policy

resource "aws_iam_policy" "s3_backend_policy" {
  name = "${var.project}-S3-Backend-Policy"
  path = "/"
  policy = data.aws_iam_policy_document.policy_doc.json
}

resource "aws_iam_role" "s3_backend_role" {
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
}

# 3. Attach the policy to the role
resource "aws_iam_role_policy_attachment" "policy_attach" {
  role = aws_iam_role.s3_backend_role.name
  policy_arn = aws_iam_policy.s3_backend_policy.arn
}

# Output
output "iam_role_arn" {
  value = aws_iam_role.s3_backend_role.arn
}
output "iam_policy_arn" {
  value = aws_iam_policy.s3_backend_policy.arn
}

# Create a group and attach the policy to the group
resource "aws_iam_group" "s3_backend_group" {
  name = "a3_backend_user"
}
resource "aws_iam_group_policy_attachment" "attach_policy" {
  group = aws_iam_group.s3_backend_group.name
  policy_arn = aws_iam_policy.s3_backend_policy.arn
}

# add current user to the group
resource "aws_iam_user_group_membership" "s3_backend_user_membership" {
  user = var.user
  groups = [aws_iam_group.s3_backend_group.name]
}