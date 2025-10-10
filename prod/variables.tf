################################################################################
# General AWS Configuration
################################################################################

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  # Consider making this required or validating format
  validation {
    condition     = can(regex("^[0-9]{12}$", var.aws_account_id))
    error_message = "AWS account ID must be a 12-digit number."
  }
}

variable "aws_region" {
  description = "AWS Region used for deployments"
  type        = string
  default     = "us-east-2"
}

variable "main_region" {
  description = "Primary region for VPC and global resources"
  type        = string
  default     = "us-east-2"
}

################################################################################
# Environment and Tagging
################################################################################

variable "env_name" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "prod"
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.env_name)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    product     = "fintech-app"
    ManagedBy   = "terraform"
    Environment = "prod"
  }
}

################################################################################
# EKS Cluster Configuration
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "prod-dominion-cluster"
}

variable "rolearn" {
  description = "IAM role ARN to be added to the aws-auth configmap as admin"
  type        = string
  default     = "arn:aws:iam::418272782718:role/terraform-create-role"
  
  validation {
    condition     = can(regex("^arn:aws:iam::[0-9]{12}:role/", var.rolearn))
    error_message = "Role ARN must be a valid IAM role ARN format."
  }
}

################################################################################
# EC2 / Client Node Configuration
################################################################################

variable "ami_id" {
  description = "AMI ID for client nodes (leave empty to auto-fetch latest Ubuntu)"
  type        = string
  default     = ""
  
  validation {
    condition     = var.ami_id == "" || can(regex("^ami-[a-z0-9]+$", var.ami_id))
    error_message = "AMI ID must be empty or a valid AMI ID starting with 'ami-'."
  }
}

variable "instance_type" {
  description = "Instance type for EC2-based client nodes"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH access"
  type        = string
  default     = "class49-dominion"
}

################################################################################
# Certificate Manager (ACM) & Route 53
################################################################################

variable "domain_name" {
  description = "Primary domain name for certificate issuance"
  type        = string
  default     = "shemphadglobalconcept.com" # Changed from wildcard to base domain
}

variable "san_domains" {
  description = "SANs (Subject Alternative Names) for SSL certificate"
  type        = list(string)
  default     = ["*.shemphadglobalconcept.com", "shemphadglobalconcept.com"]
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID for domain validation"
  type        = string
  default     = "Z0417665P4L85VA3F3F6"
  
  validation {
    condition     = can(regex("^Z[0-9A-Z]+$", var.route53_zone_id))
    error_message = "Route53 zone ID must be a valid hosted zone ID."
  }
}

################################################################################
# ECR Repositories
################################################################################

variable "repositories" {
  description = "List of ECR repositories to create"
  type        = list(string)
  default     = ["fintech-app", "gateway"]
  
  validation {
    condition = alltrue([
      for repo in var.repositories : can(regex("^[a-z0-9-]+$", repo))
    ])
    error_message = "Repository names must contain only lowercase letters, numbers, and hyphens."
  }
}

################################################################################
# Kubernetes Namespaces (for add-ons or app grouping)
################################################################################

variable "namespaces" {
  description = "Kubernetes namespace configurations with annotations and labels"
  type = map(object({
    annotations = optional(map(string), {})
    labels      = optional(map(string), {})
  }))
  default = {
    fintech = {
      annotations = {
        name = "fintech"
      }
      labels = {
        app = "webapp"
      }
    }
    monitoring = {
      annotations = {
        name = "monitoring"
      }
      labels = {
        app = "webapp"
      }
    }
  }
}

################################################################################
# Additional Recommended Variables
################################################################################

variable "create_ecr_repositories" {
  description = "Whether to create ECR repositories"
  type        = bool
  default     = true
}

variable "enable_cluster_logging" {
  description = "Enable EKS cluster control plane logging"
  type        = bool
  default     = true
}

variable "cluster_log_types" {
  description = "List of EKS control plane log types to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  
  validation {
    condition = alltrue([
      for log_type in var.cluster_log_types : contains([
        "api", "audit", "authenticator", "controllerManager", "scheduler"
      ], log_type)
    ])
    error_message = "Log type must be one of: api, audit, authenticator, controllerManager, scheduler."
  }
}
