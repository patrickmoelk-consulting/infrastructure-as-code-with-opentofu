terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }

  backend "s3" {
    region       = "eu-central-1"
    bucket       = "iac-workshop-bucket-02-05-NAME-state"
    key          = "tofu.tfstate"
    encrypt      = true
    use_lockfile = true

    ## uncomment when using localstack
    # endpoints = {
    #   s3 = "http://s3.localhost.localstack.cloud:4566"
    # }
  }
}

provider "aws" {
  region = var.aws_region

  ## uncomment when using localstack
  # skip_credentials_validation = true
  # skip_metadata_api_check     = true
  # skip_requesting_account_id  = true

  # endpoints {
  #   s3 = "http://s3.localhost.localstack.cloud:4566"
  # }
}

