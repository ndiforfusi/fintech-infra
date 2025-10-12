# terraform.tfvars
region              = "us-east-2"
bucket_name         = "infra-chide" # must be lowercase & globally unique
dynamodb_table_name = "infra-chide_db"
enable_versioning   = true
force_destroy       = false

tags = {
  Project     = "terraform-backend-bootstrap"
  Environment = "prod"
}

