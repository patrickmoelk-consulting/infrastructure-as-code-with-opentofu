resource "docker_network" "todo_list_app_network" {
  name   = "todo_list_app"
  driver = "bridge"
}
