include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../module"
}

inputs = {
  bucket_name = "iac-workshop-04-05-YOUR-NAME-1"
}
