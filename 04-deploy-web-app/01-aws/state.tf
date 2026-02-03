## optional 
## uncomment the following lines to create a bucket for remote state, 
## then run tf apply
## then uncomment the backend {} block in providers.tf and run tf apply

# locals {
#   state_bucket_name = "iac-workshop-bucket-03-01-YOUR-NAME-state"
# }

# resource "aws_s3_bucket" "state" {
#   bucket = local.state_bucket_name
# }

# output "state_bucket_name" {
#   value = aws_s3_bucket.state.bucket
# }
