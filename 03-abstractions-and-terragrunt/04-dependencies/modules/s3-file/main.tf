variable "bucket_name" {
  type = string
}

variable "key" {
  type = string
}

variable "content" {
  type = string
}

resource "aws_s3_object" "file" {
  bucket  = var.bucket_name
  key     = var.key
  content = var.content
}
