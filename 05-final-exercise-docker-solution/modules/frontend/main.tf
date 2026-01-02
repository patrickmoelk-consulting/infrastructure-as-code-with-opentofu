locals {
  remote_user          = "ubuntu"
  remote_home_dir      = "/home/${local.remote_user}"
  remote_app_path      = "${local.remote_home_dir}/apps/todos"

  local_app_path      = "${var.repo_root}/apps/todos"
  local_frontend_path  = "${local.local_app_path}/frontend"
}

resource "docker_container" "todo_list_frontend" {
  image = docker_image.ubuntu.image_id
  name  = "todo-list-app-frontend-${var.env}"

  networks_advanced {
    name = var.docker_network_name
  }

  provisioner "local-exec" {
    working_dir = local.local_frontend_path
    command     = "npm run build"
  }

  upload {
    source     = "${path.module}/assets/init-script.sh"
    file       = "${local.remote_home_dir}/init-script.sh"
    executable = true
  }

  upload {
    file = "${local.remote_app_path}/Caddyfile"
    content = templatefile("${local.local_app_path}/Caddyfile.prod.tftpl", {
      backend_host = "${var.backend_host}"
    })
  }

  volumes {
    container_path = "/srv/todo-list-app-frontend/"
    host_path      = "${local.local_frontend_path}/dist"
  }

  ports {
    internal = 80
    external = var.port
  }

  command = ["${local.remote_home_dir}/init-script.sh"]
}

resource "docker_image" "ubuntu" {
  name         = var.docker_image
  keep_locally = true
}
