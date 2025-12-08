variable "aws_region" {
  type        = string
  description = "AWS region, e.g. eu-central-1 or us-east-1"
  default     = "eu-central-1"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
  default     = "iac-workshop-bucket-03"
}

variable "environment" {
  type        = string
  description = "Environment: dev, staging, or prod"
  validation {
    condition     = var.environment == "dev" || var.environment == "staging" || var.environment == "prod"
    error_message = "var.environment MUST be one of 'dev', 'staging', or 'prod'"
  }
  default = "dev"
}
