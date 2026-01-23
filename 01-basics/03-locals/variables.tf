variable "aws_region" {
  default = "eu-central-1"
}

variable "s3_bucket_name" {
  default = "iac-workshop-bucket-01-03"
}

variable "name" {
  default = "YOUR-NAME"
}

variable "environment" {
  description = "environment: 'dev', 'staging', or 'prod'"
  validation {
    condition     = var.environment == "dev" || var.environment == "staging" || var.environment == "prod"
    error_message = "var.environment MUST be either 'dev', 'staging', or 'prod'"
  }
}
