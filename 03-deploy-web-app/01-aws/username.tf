locals {
  username = lower(replace(data.local_command.username.stdout, "\n", ""))
}

data "local_command" "username" {
  command = "whoami"
}
