include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/s3-file"
}

dependency "s3_bucket" {
  config_path = "../s3-bucket"
}

inputs = {
  bucket_name = dependency.s3_bucket.outputs.s3_bucket_name
  key = "foo.txt"
  contents = "foo bar"
}