terraform {
  required_version = ">=0.12.0"
  backend "s3" {
    key            = "bright-s3-bucket/Fintech-Project/"
    bucket         = "bright-s3-bucket"
    region         = "ap-northeast-2"
    dynamodb_table = "Fintech-locks"
  }
}
