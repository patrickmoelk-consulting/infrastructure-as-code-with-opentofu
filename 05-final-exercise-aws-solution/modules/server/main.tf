locals {
  remote_user          = "ubuntu"
  remote_home_dir      = "/home/${local.remote_user}"
  remote_app_path      = "${local.remote_home_dir}/apps/todos"
  remote_backend_path  = "${local.remote_home_dir}/apps/todos/backend"
  remote_frontend_path = "${local.remote_home_dir}/apps/todos/frontend"

  local_app_path      = "${var.repo_root}/apps/todos"
  local_backend_path  = "${var.repo_root}/apps/todos/backend-py"
  local_frontend_path = "${var.repo_root}/apps/todos/frontend"
}


resource "aws_spot_instance_request" "todo-list-app" {
  ami                  = data.aws_ami.search.image_id
  instance_type        = var.aws_ec2_instance_type
  key_name             = aws_key_pair.todo-list.key_name
  security_groups      = var.security_group_names
  wait_for_fulfillment = true

  connection {
    type        = "ssh"
    user        = local.remote_user
    host        = self.public_dns
    private_key = file(var.private_key_local_filepath)
    # agent = true
  }

  provisioner "remote-exec" {
    inline = ["mkdir -p ${local.remote_app_path}"]
  }

  provisioner "file" {
    source      = local.local_backend_path
    destination = local.remote_backend_path
  }

  provisioner "file" {
    content = templatefile("${local.local_backend_path}/.env.prod.tftpl", {
      db_host     = var.db_host
      db_port     = var.db_port
      db_name     = var.db_name
      db_user     = var.db_user
      db_password = var.db_password
    })
    destination = "${local.remote_backend_path}/.env.prod"
  }

  provisioner "local-exec" {
    working_dir = local.local_frontend_path
    command     = "npm run build"
  }

  provisioner "file" {
    source      = "${local.local_frontend_path}/dist"
    destination = local.remote_frontend_path
  }

  provisioner "file" {
    source      = "${path.module}/assets/todo-list-app-backend.service"
    destination = "${local.remote_app_path}/todo-list-app-backend.service"
  }

  provisioner "file" {
    content = templatefile("${local.local_app_path}/Caddyfile.prod.tftpl", {
      backend_host = "localhost"
    })
    destination = "${local.remote_app_path}/Caddyfile"
  }

  provisioner "remote-exec" {
    script = "${path.module}/assets/init-script.sh"
  }
}

data "aws_ami" "search" {
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-20251022"]
  }
}


resource "aws_key_pair" "todo-list" {
  key_name   = "todo-list"
  public_key = data.local_file.todo-list-public-key.content
}

data "local_file" "todo-list-public-key" {
  filename = var.public_key_local_filepath
}
