# Terraform file to define variables

# region variable
variable "region" {
  type = string
  default = "us-west-1"
}

# project variable
variable "project" {
  type = string
  default = "my-project-terraform-backend"
  description = "The name of the project"
}

# principal arn variable -> create IAM policies
# arn Official Links: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html
variable "principal_arn" {
  type = list(string)
  default = null
  description = "A list of ARNs to allow access to the IAM role"
}