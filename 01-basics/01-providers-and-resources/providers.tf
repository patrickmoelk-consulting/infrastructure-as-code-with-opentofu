terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"

  # set credentials here unless you're using localstack rather than the regular, real AWS
  # WARNING: this is bad practice! NEVER commit secrets to version control! We'll address this later.
  access_key = "foo"
  secret_key = "bar"

  ## uncomment when using localstack
  # skip_credentials_validation = true
  # skip_metadata_api_check     = true
  # skip_requesting_account_id  = true

  # endpoints {
  #   s3  = "http://s3.localhost.localstack.cloud:4566"
  # }
}
