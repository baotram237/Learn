# using IAM role

resource "aws_iam_role" "glue_role" {
  name = "aws-glue-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "glue_policy" {
  name = "aws-glue-role-policy"
  role = aws_iam_role.glue_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          var.aws_s3_bucket_arn,
          "${var.aws_s3_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "glue:*",
          "logs:*",
          "cloudwatch:*",
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:AttachNetworkInterface"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "redshift_role" {
  name = "aws-redshift-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "redshift.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "redshift_policy" {
  name = "aws-redshift-role-policy"
  role = aws_iam_role.redshift_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          var.aws_s3_bucket_arn,
          "${var.aws_s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

# output
output "redshift_role_arn" {
  value = aws_iam_role.redshift_role.arn
}

output "aws_glue_role_arn" {
  value = aws_iam_role.glue_role.arn
}