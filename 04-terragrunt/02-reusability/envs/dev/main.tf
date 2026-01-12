variable "content" {
  default = ""
}

module "file" {
  source = "../../module"

  content = var.content != "" ? var.content : "Dev tf content"
}
