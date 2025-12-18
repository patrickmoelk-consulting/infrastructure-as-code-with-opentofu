resource "docker_container" "database" {
  image = docker_image.postgres.image_id
  name  = "todo-list-app-db"

  networks_advanced {
    name = docker_network.todo_list_app_network.name
  }

  env = [
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_username}",
    "POSTGRES_PASSWORD=${var.db_password}",
  ]
}
