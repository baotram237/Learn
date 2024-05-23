variable "project" {
  description = "The project name"
  type        = string
  default = "trambao-lab"
}

variable "user" {
  description = "The user name"
  type        = string
  default = "trambao"
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
}

variable "dynamodb_table_arn" {
  description = "The ARN of the dynamodb table"
}


variable "principal_arn" {
  description = "A list of ARNs to allow access to the IAM role"
  type        = list(string)
  default     = null
}

data "aws_caller_identity" "current" {
}
locals {
  principal_arns = var.principal_arn != null ? var.principal_arn : [data.aws_caller_identity.current.arn]
}

