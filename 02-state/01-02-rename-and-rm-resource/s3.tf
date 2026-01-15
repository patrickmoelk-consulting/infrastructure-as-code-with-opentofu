locals {
  bucket_name = lower(replace("${var.s3_bucket_name}-${data.local_command.name.stdout}", "\n", ""))
}

data "local_command" "name" {
  command = "whoami"
}

resource "aws_s3_bucket" "my_buckt" {
  bucket = local.bucket_name
}
