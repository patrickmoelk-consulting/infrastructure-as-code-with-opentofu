locals {
  env = "dev"
  path_to_secrets_tfvars = find_in_parent_folders(".secrets.tfvars")
  path_to_common_tfvars = find_in_parent_folders("common.tfvars")
  secrets = jsondecode(read_tfvars_file(local.path_to_secrets_tfvars))
  common = jsondecode(read_tfvars_file(local.path_to_common_tfvars))
  repo_root = get_repo_root()
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.9.0"
    }
  }
}

provider "docker" {
  host = "${local.secrets.docker_socket}"
}
EOF
}