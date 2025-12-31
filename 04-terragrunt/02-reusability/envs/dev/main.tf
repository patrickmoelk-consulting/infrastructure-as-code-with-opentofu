variable "content" {}

module "file" {
  source = "../../module"

  content = var.content
}
