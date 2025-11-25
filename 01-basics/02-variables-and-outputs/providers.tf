provider "aws" {
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  region                      = var.aws_region
  skip_credentials_validation = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://s3.localhost.localstack.cloud:4566"
  }
}
