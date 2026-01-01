include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/db"
  
  extra_arguments "secrets" {
    commands = get_terraform_commands_that_need_vars()
    arguments = ["-var-file=${get_terragrunt_dir()}/.secrets.tfvars"]
  }
}

dependency "networking" {
  config_path = "../networking"
}

inputs = {
  subnet_group_name = dependency.networking.outputs.db_subnet_group_name
  security_group_ids = dependency.networking.outputs.db_security_group_ids
}
