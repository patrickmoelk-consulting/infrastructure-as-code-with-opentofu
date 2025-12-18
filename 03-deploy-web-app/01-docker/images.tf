resource "docker_image" "ubuntu" {
  name         = var.docker_image_backend
  keep_locally = true
}

resource "docker_image" "postgres" {
  name         = "postgres:13-alpine"
  keep_locally = true
}
