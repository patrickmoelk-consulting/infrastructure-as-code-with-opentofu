include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../module"
}

inputs = {
  content = "Prod tg content"
}