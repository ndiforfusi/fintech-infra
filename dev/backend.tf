terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "dev/terraform.state"
    bucket         = "class40-terraform-backend-bucket-chris "
    region         = "us-east-2"
    dynamodb_table = "terraform-state-locking"
  }
}
