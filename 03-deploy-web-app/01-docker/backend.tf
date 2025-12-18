resource "docker_container" "todo_list_backend" {
  image = docker_image.ubuntu.image_id
  name  = "todo-list-app-backend"

  networks_advanced {
    name = docker_network.todo_list_app_network.name
  }

  upload {
    source     = "${path.module}/assets/init-script-backend.sh"
    file       = "${local.remote_home_dir}/init-script.sh"
    executable = true
  }

  volumes {
    container_path = local.remote_backend_path
    host_path      = local.local_backend_path
  }

  env = [
    "POSTGRES_HOST=${docker_container.database.name}",
    "POSTGRES_PORT=5432",
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_username}",
    "POSTGRES_PASSWORD=${var.db_password}",
  ]

  command = ["${local.remote_home_dir}/init-script.sh"]
}
