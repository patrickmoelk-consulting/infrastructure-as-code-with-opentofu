terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.22.0"
    }
  }

  backend "s3" {
    region       = "eu-central-1"
    bucket       = "iac-workshop-bucket-02-05-NAME-state"
    key          = "opentofu-state"
    use_lockfile = true

    endpoints = {
      s3 = "http://s3.localhost.localstack.cloud:4566"
    }
  }
}

provider "aws" {
  region                      = var.aws_region
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://s3.localhost.localstack.cloud:4566"
  }
}

