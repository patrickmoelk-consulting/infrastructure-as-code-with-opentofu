resource "docker_network" "todo_list_app_network" {
  name   = var.network_name
  driver = "bridge"
}
