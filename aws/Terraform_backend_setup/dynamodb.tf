# dynamoDB.tf file to create DynamoDB resources and some configurations
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
# Required configuration of Terraform backend with DynamoDB to save Lock State

# required attributes: name, hash_key, attribute (only required for hash_key and range_key)

# DynamoDB Table explain:
    # Hash Key: LockID - Hash key is a simple primary key that is used to uniquely identify an item in a table.
    # Attribute of hash_key: type S (String)
resource "aws_dynamodb_table" "dynamodb_table" {
  name = "${var.project}-s3-backend"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"

    attribute {
        name = "LockID"
        type = "S"
    }

    tags = local.tags
}

