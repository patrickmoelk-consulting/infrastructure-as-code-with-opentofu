variable "docker_network_name" { type = string }

variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
variable "env" { type = string }