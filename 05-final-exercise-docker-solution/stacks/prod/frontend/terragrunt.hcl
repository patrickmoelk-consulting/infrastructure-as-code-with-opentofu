include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/frontend"
}

dependency "network" {
  config_path = "../network"
}

dependency "backend" {
  config_path = "../backend"
}

inputs = {
  env = include.root.locals.env
  docker_network_name = dependency.network.outputs.network_name
  port = 9090
  backend_host = dependency.backend.outputs.host
  repo_root = include.root.locals.repo_root
}