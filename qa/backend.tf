terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "qa/terraform.state"
    bucket         = "class38dominion-terraform-backend5"
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locking"
  }
}
