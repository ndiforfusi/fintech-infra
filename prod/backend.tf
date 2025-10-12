terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "prod/terraform.state"
    bucket         = "infra-chide"
    region         = "us-east-2"
    dynamodb_table = "infra-chide_db"
  }
}
