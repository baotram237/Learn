# DynamoDB: official documentation: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html

# Create DynamoDB table with CLI

# aws dynamodb create-table \
#     --table-name demo-dynamodb-table \
#     --attribute-definitions \
#         AttributeName=Animal,AttributeType=S \
#         AttributeName=Number,AttributeType=N \
#     --key-schema AttributeName=Animal,KeyType=HASH AttributeName=Number,KeyType=RANGE \
#     --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
#     --table-class STANDARD

# explain the configuration
# table-name: name of the table
# attribute-definitions: define the attributes of the table
# key-schema: define the primary key of the table
# -> HASH: partition key
# -> RANGE: sort key
# provisioned-throughput: define the read and write capacity of the table

# Use Terraform to create the DynamoDB table to store the Terraform state
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table

resource "aws_dynamodb_table" "dynamodb_table" {
  name = "${var.project}-s3-backend"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"

    attribute {
        name = "LockID"
        type = "S"
    }
}

resource "aws_dynamodb_table" "dynamodb_table_test" {
  name = "${var.project}-s3-backend-lock-state"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"

    attribute {
        name = "LockID"
        type = "S"
    }
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.dynamodb_table.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.dynamodb_table.name
}