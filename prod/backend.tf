terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket         = "infra-chide"
    key            = "fintech-infra/terraform.tfstate"   # use .tfstate (your file had ".state")
    region         = "us-east-2"
    dynamodb_table = "infra-chide_db"
    encrypt        = true
  }
}
