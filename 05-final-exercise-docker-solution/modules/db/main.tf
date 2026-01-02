resource "docker_container" "database" {
  image = docker_image.postgres.image_id
  name  = "todo-list-app-db-${var.env}"

  networks_advanced {
    name = var.docker_network_name
  }

  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_username}",
    "POSTGRES_PASSWORD=${var.db_password}",
  ]
}

resource "docker_image" "postgres" {
  name         = "postgres:13-alpine"
  keep_locally = true
}
