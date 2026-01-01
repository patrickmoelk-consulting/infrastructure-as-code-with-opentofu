remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "iac-workshop-04-04-remote-state-name"

    key          = "${path_relative_to_include()}/tofu.tfstate"
    region       = "eu-central-1"
    encrypt      = true
    use_lockfile = true
    encrypt      = true

    # endpoints = {
    #   s3 = "http://s3.localhost.localstack.cloud:4566"
    # }
  }
}
