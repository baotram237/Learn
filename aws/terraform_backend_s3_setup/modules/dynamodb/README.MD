# AWS Command Line Interface
```bash
aws dynamodb create-table --cli-input-json file://dynamodb_table.json
```
aws dynamodb create-table --table-name Music --attribute-definitions AttributeName=Artist,AttributeType=S AttributeName=SongTitle,AttributeType=S --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 --table-class STANDARD
```
aws dynamodb delete-table --table-name Music
```
aws dynamodb describe-table --table-name Music
```aws dynamodb list-tables 
etc
```