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
