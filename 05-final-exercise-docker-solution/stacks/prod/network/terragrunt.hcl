include "root" {
  path = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = "../../../modules/network"
}

inputs = {
  network_name = "todo_list_net_prod"
}