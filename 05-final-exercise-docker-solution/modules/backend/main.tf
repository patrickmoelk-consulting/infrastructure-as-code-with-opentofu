locals {
  remote_user          = "ubuntu"
  remote_home_dir      = "/home/${local.remote_user}"
  remote_app_path      = "${local.remote_home_dir}/apps/todos"
  remote_backend_path  = "${local.remote_app_path}/backend"

  local_app_path      = "${var.repo_root}/apps/todos"
  local_backend_path  = "${local.local_app_path}/backend-py"
}

resource "docker_container" "backend" {
  image = docker_image.ubuntu.image_id
  name  = "todo-list-app-backend-${var.env}"

  networks_advanced {
    name = var.docker_network_name
  }

  upload {
    source     = "${path.module}/assets/init-script.sh"
    file       = "${local.remote_home_dir}/init-script.sh"
    executable = true
  }

  volumes {
    container_path = local.remote_backend_path
    host_path      = local.local_backend_path
  }

  env = [
    "POSTGRES_HOST=${var.db_host}",
    "POSTGRES_PORT=${var.db_port}",
    "POSTGRES_DB=${var.db_name}",
    "POSTGRES_USER=${var.db_username}",
    "POSTGRES_PASSWORD=${var.db_password}",
  ]

  command = ["${local.remote_home_dir}/init-script.sh"]
}

resource "docker_image" "ubuntu" {
  name         = var.docker_image
  keep_locally = true
}
