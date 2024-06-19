provider "aws" {
  region = var.aws_region
}

# Resources - Official Documents:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_table#storage_descriptor
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_job

# Glue data Catalog Database and Table
resource "aws_glue_catalog_database" "glue_database" {
  name = "demo_catalog_database"
}

resource "aws_glue_catalog_table" "glue_table" {
  name = "demo_catalog_table"
  database_name = aws_glue_catalog_database.glue_database.name
}

# Glue ETL Job
resource "aws_glue_job" "glue_etl_job" {
  name = "s3_to_redshift_etl"
  role_arn = module.IAM.aws_glue_role_arn
  # ETL scripts location
  command {
    script_location = "s3://${var.aws_s3_bucket}/glue_script.py"
  }
}

module "IAM" {
  source = "../modules/IAM"
  aws_s3_bucket_arn = module.S3.aws_s3_bucket_arn
}

module "S3" {
  source = "../modules/S3"
}

module "Redshift" {
  source = "../modules/Redshift"
  redshift_role_arn = [module.IAM.redshift_role_arn]
}