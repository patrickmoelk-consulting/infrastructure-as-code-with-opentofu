terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.22.0" # 6.23.x causes errors with localstack: `operation error S3 Control: ListTagsForResource, failed to resolve service endpoint, endpoint rule error`
    }
  }
}

provider "aws" {
  access_key                  = "foo"
  secret_key                  = "bar"
  region                      = "eu-central-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    s3  = "http://s3.localhost.localstack.cloud:4566"
  }
}
