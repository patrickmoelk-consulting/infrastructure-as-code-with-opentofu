variable "docker_network_name" { type = string }

variable "db_host" { type = string }
variable "db_port" { type = number }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
variable "env" { type = string }

variable "repo_root" { type = string }

variable "docker_image" {
  default = "ubuntu:24.04"
}
