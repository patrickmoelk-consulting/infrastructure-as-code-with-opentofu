variable "content" {}

resource "local_file" "txt_file" {
  content  = var.content
  filename = "${path.root}/hello.txt"
}
