import boto3

# just quickstart: interact with s3
# create s3 bucket:
s3_client = boto3.client('s3')
bucket_name = 'demo-bucket'
s3_client.create_bucket(Bucket=bucket_name)

print(f"Bucket '{bucket_name}' created successfully.")
s3 = boto3.resource('s3')

for bucket in s3.buckets.all():
    print(bucket.name)

buckets = list(s3.buckets.all())
print(buckets)
# Retrieve a bucket's ACL
s3 = boto3.client('s3')
result = s3.get_bucket_acl(Bucket=bucket_name)
print(result)

# work with DynamoDb
# Official doc: https://boto3.amazonaws.com/v1/documentation/api/latest/guide/dynamodb.html
    #1. Create a new table
# get the service resource:
dynamodb = boto3.resource('dynamodb')
# create the DynamoDb table
# table = dynamodb.create_table(
#     TableName= 'demo_table',
#     KeySchema= [
#         {
#             'AttributeName':'username',
#             'KeyType':'HASH'
#         },
#         {
#             'AttributeName':'last_name',
#             'KeyType': 'RANGE'
#         }
#     ],
#     AttributeDefinitions= [
#         {
#             'AttributeName':'username',
#             'AttributeType':'S'
#         },
#         {
#             'AttributeName': 'last_name',
#             'AttributeType':'S'
#         }
#     ],
#     ProvisionedThroughput={
#         'ReadCapacityUnits':5,
#         'WriteCapacityUnits':5
#     }
# )

# print table items
# Print out some data about the table.
print('DynamoDB example')
table = dynamodb.Table("demo_table")
print(table.item_count)
# add items to table
table.put_item(
   Item={
        'username': 'janedoe',
        'first_name': 'Jane',
        'last_name': 'Doe',
        'age': 25,
        'account_type': 'standard_user',
    }
)
# batch writing
with table.batch_writer() as batch:
    batch.put_item(
        Item={
            'account_type': 'standard_user',
            'username': 'johndoe',
            'first_name': 'John',
            'last_name': 'Doe',
            'age': 25,
            'address': {
                'road': '1 Jefferson Street',
                'city': 'Los Angeles',
                'state': 'CA',
                'zipcode': 90001
            }
        }
    )
    batch.put_item(
        Item={
            'account_type': 'super_user',
            'username': 'janedoering',
            'first_name': 'Jane',
            'last_name': 'Doering',
            'age': 40,
            'address': {
                'road': '2 Washington Avenue',
                'city': 'Seattle',
                'state': 'WA',
                'zipcode': 98109
            }
        }
    )
    batch.put_item(
        Item={
            'account_type': 'standard_user',
            'username': 'bobsmith',
            'first_name': 'Bob',
            'last_name':  'Smith',
            'age': 18,
            'address': {
                'road': '3 Madison Lane',
                'city': 'Louisville',
                'state': 'KY',
                'zipcode': 40213
            }
        }
    )
    batch.put_item(
        Item={
            'account_type': 'super_user',
            'username': 'alicedoe',
            'first_name': 'Alice',
            'last_name': 'Doe',
            'age': 27,
            'address': {
                'road': '1 Jefferson Street',
                'city': 'Los Angeles',
                'state': 'CA',
                'zipcode': 90001
            }
        }
    )
#