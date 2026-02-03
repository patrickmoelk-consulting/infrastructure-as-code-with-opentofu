variable "db_name" {
  default = "todos"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  type = string
}

variable "docker_image_backend" {
  default = "ubuntu:24.04"
}

variable "docker_socket" {
  description = "path to docker socket, e.g. unix:///var/run/docker.sock or on MacOS typically unix:///Users/USERNAME/.docker/run/docker.sock"
}
