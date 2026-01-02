include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/db"
}

dependency "network" {
  config_path = "../network"
}

inputs = {
  env = include.root.locals.env
  docker_network_name = dependency.network.outputs.network_name
  db_name = include.root.locals.common.db_name
  db_username = include.root.locals.common.db_username
  db_password = include.root.locals.secrets.db_password
}