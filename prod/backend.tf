cluster_certificate_authority_dataterraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "prod/terraform.tfstate"
    bucket         = "class390-terraform-backend-bucket"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
  }
}
