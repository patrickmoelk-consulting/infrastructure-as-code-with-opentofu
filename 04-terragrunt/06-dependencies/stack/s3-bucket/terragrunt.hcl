include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../modules/s3-bucket"
}

inputs = {
  bucket_name = "iac-workshop-04-06-YOUR-NAME"
}
