# Terraform file define variables

variable "region" {
  description = "The AWS region to deploy to"
  type        = string
  default = "us-west-1"
}

variable "project" {
  description = "The project name"
  type        = string
  default = "trambao-lab"
}