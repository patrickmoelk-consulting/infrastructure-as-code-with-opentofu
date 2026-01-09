variable "bucket_name" {}

resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.s3.bucket
}