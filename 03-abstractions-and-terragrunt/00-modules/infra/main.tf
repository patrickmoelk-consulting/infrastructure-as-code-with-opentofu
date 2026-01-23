locals {
  bucket_name = lower(replace("iac-workshop-bucket-03-01-${data.local_command.username.stdout}", "\n", ""))
}

data "local_command" "username" {
  command = "whoami"
}
