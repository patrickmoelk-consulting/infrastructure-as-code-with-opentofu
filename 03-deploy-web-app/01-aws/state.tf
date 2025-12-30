# locals {
#   state_bucket_name = "iac-workshop-bucket-03-01-patrick-state"
# }

# resource "aws_s3_bucket" "state" {
#   bucket = local.state_bucket_name
# }

# output "state_bucket_name" {
#   value = aws_s3_bucket.state.bucket
# }
