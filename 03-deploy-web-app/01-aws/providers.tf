terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }

  backend "s3" {
    region       = "eu-central-1"
    bucket       = "iac-workshop-bucket-03-01-YOUR-NAME-state"
    key          = "tofu.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = var.aws_region

  ## this exercise does not work with the free localstack
}

