# object as output
output "s3_bucket" {
  value = aws_s3_bucket.my_bucket
}

# single values as output
output "s3_bucket_domain" {
  value = aws_s3_bucket.my_bucket.bucket_domain_name
}

output "s3_bucket_regional_domain" {
  value = aws_s3_bucket.my_bucket.bucket_regional_domain_name
}
