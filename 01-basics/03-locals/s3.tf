locals {
  bucket_name = var.environment == "prod" ? "${var.s3_bucket_name}-${var.name}" : "${var.s3_bucket_name}-${var.name}-${var.environment}"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = local.bucket_name
}
