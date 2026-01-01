locals {
  aws_region = "eu-central-1"
  repo_root = get_repo_root()
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "iac-workshop-05-dev-name"

    key          = "${path_relative_to_include()}/tofu.tfstate"
    region       = "${local.aws_region}"
    encrypt      = true
    use_lockfile = true
    encrypt      = true

    # endpoints = {
    #   s3 = "http://s3.localhost.localstack.cloud:4566"
    # }
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.22.0"
    }
  }
}

provider "aws" {
  region = "${local.aws_region}"
}
EOF
}