variable "bucket_name" {}
variable "key" {}
variable "contents" {}

resource "aws_s3_object" "file" {
  bucket  = var.bucket_name
  key     = var.key
  content = var.contents
}
