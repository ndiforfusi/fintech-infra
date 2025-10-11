terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "prod/terraform.state"
    bucket         = "microlab-bucket"
    region         = "us-east-2"
    dynamodb_table = "Microlab-dB"
  }
}
