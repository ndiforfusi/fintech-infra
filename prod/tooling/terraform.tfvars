# terraform.tfvars
region              = "us-east-2"
bucket_name         = "microlab"     # must be lowercase & globally unique
dynamodb_table_name = "microla_db"
enable_versioning   = true
force_destroy       = false

tags = {
  Project     = "terraform-backend-bootstrap"
  Environment = "prod"
}

