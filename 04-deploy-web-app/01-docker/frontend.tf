resource "docker_container" "todo_list_frontend" {
  image = docker_image.ubuntu.image_id
  name  = "todo-list-app-frontend"

  networks_advanced {
    name = docker_network.todo_list_app_network.name
  }

  provisioner "local-exec" {
    working_dir = local.local_frontend_path
    command     = "npm ci; npm run build"
  }

  upload {
    source     = "${path.module}/assets/init-script-frontend.sh"
    file       = "${local.remote_home_dir}/init-script.sh"
    executable = true
  }

  upload {
    file = "${local.remote_app_path}/Caddyfile"
    content = templatefile("${local.local_app_path}/Caddyfile.prod.tftpl", {
      backend_host = "${docker_container.todo_list_backend.name}"
    })
  }

  volumes {
    container_path = "/srv/todo-list-app-frontend/"
    host_path      = "${local.local_frontend_path}/dist"
  }

  ports {
    internal = 80
    external = 8080
  }

  command = ["${local.remote_home_dir}/init-script.sh"]
}
