terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket         = "class390-terraform-backend-bucket"
    key            = "prod/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-state-locking"
  }
}
