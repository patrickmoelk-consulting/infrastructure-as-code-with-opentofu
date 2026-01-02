include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/backend"
}

dependency "network" {
  config_path = "../network"
}

dependency "db" {
  config_path = "../db"
}

inputs = {
  env = include.root.locals.env
  docker_network_name = dependency.network.outputs.network_name
  db_host = dependency.db.outputs.host
  db_port = 5432
  db_name = include.root.locals.common.db_name
  db_username = include.root.locals.common.db_username
  db_password = include.root.locals.secrets.db_password
  repo_root = include.root.locals.repo_root
}