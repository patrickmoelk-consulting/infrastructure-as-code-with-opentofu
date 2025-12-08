locals {
  bucket_name = "${var.s3_bucket_name}-${data.local_command.name.stdout}"
}

data "local_command" "name" {
  command = "whoami"
}

resource "aws_s3_bucket" "my_buckt" {
  bucket = local.bucket_name

  lifecycle {
    prevent_destroy = true
  }
}
