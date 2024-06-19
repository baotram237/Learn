# Create Redshift Cluster
resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "mydb"
  master_username    = "masteruser"
  master_password    = "Password64"
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  iam_roles          = var.redshift_role_arn
  multi_az           = true
}


