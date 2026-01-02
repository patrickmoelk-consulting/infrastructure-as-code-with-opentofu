variable "docker_network_name" { type = string }

variable "port" { type = number }
variable "backend_host" { type = string }

variable "repo_root" { type = string }

variable "docker_image" {
  default = "ubuntu:24.04"
}
variable "env" { type = string }