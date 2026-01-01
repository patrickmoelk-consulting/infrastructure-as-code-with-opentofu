include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/server"

  extra_arguments "secrets" {
    commands = get_terraform_commands_that_need_vars()
    arguments = ["-var-file=${get_terragrunt_dir()}/.secrets.tfvars"]
  }
}

dependency "networking" {
  config_path = "../networking"
}

dependency "db" {
  config_path = "../db"
}


inputs = {
  repo_root = include.root.locals.repo_root
  security_group_names = dependency.networking.outputs.app_security_group_names
  db_host = dependency.db.outputs.host
  db_port = dependency.db.outputs.port
  db_name = dependency.db.outputs.db_name
  db_user = dependency.db.outputs.user
}