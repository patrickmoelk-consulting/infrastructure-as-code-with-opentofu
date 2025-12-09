locals {
  state_bucket_name = "${local.bucket_name}-state"
}

resource "aws_s3_bucket" "state" {
  bucket = local.state_bucket_name
}

output "state_bucket_name" {
  value = aws_s3_bucket.state.bucket
}