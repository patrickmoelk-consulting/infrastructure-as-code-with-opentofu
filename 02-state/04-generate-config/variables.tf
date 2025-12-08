variable "aws_region" {
  type        = string
  description = "AWS region, e.g. eu-central-1 or us-east-1"
  default     = "eu-central-1"
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
  default     = "iac-workshop-bucket"
}
