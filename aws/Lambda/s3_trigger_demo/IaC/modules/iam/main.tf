# Create aws_iam_policy_document
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [ "sts:AssumeRole" ]
    principals {
      type = "Service"
      identifiers = [ 
        "lambda.amazonaws.com"
       ]
    }
  }
}
# aws_iam_policy
resource "aws_iam_policy" "s3_trigger_policy" {
  name = "${var.project_name}-s3-trigger-policy"
  policy = templatefile("${path.module}/policy_doc.json",
    {
    aws_region = var.region
    }
  )
}
# aws_iam_role
resource "aws_iam_role" "s3_trigger_role" {
  name = "${var.project_name}-s3-trigger-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}
# aws_iam_policy_attachment
resource "aws_iam_policy_attachment" "aws_iam_policy_attachment" {
    name = "iam_user_attachment"
    users = [var.user_name]
    roles = aws_iam_role.s3_trigger_role.managed_policy_arns
    policy_arn = aws_iam_policy.s3_trigger_policy.arn
}
# output arn
output "s3_trigger_role_arn" {
  description = "The ARN of the s3 trigger role"
  value       = aws_iam_role.s3_trigger_role.arn
}