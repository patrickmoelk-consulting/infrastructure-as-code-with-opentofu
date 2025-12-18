locals {
  remote_user          = "ubuntu"
  remote_home_dir      = "/home/${local.remote_user}"
  remote_app_path      = "${local.remote_home_dir}/apps/todos"
  remote_backend_path  = "${local.remote_home_dir}/apps/todos/backend"
  remote_frontend_path = "${local.remote_home_dir}/apps/todos/frontend"

  local_app_path      = "${abspath(path.module)}/../../apps"
  local_backend_path  = "${abspath(path.module)}/../../apps/backend/todos"
  local_frontend_path = "${abspath(path.module)}/../../apps/frontend/todos"
}
