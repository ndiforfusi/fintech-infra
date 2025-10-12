variable "region" {
  description = "AWS region for S3 and DynamoDB"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "classproject-bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "project"
  type        = string
  default     = "terraform-locks"
}

variable "enable_versioning" {
  description = "Enable S3 versioning (recommended for state rollback safety)"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow bucket destroy even if not empty (use with caution)"
  type        = bool
  default     = false
}

variable "kms_key_id" {
  description = "Optional KMS key ID/ARN for bucket encryption (empty = use AES256)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {
    Project = "terraform-backend-bootstrap"
    Managed = "terraform"
  }
}
