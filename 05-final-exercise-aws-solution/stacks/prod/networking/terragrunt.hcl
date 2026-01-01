include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/networking"
}

inputs = {
  aws_region = include.root.locals.aws_region
}