remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "iac-workshop-04-06-remote-state-YOUR-NAME"

    key          = "${path_relative_to_include()}/tofu.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true

    ## uncomment when using localstack
    # skip_credentials_validation = true
    # skip_metadata_api_check     = true
    # skip_requesting_account_id  = true

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
      version = "~>6.27.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"

  ## uncomment when using localstack
  # skip_credentials_validation = true
  # skip_metadata_api_check     = true
  # skip_requesting_account_id  = true

  # endpoints {
  #   s3             = "http://s3.localhost.localstack.cloud:4566"
  # }
}
EOF
}