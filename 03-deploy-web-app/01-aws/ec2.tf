locals {
  remote_user          = "ubuntu"
  remote_home_dir      = "/home/${local.remote_user}"
  remote_app_path      = "${local.remote_home_dir}/apps/todos"
  remote_backend_path  = "${local.remote_home_dir}/apps/todos/backend"
  remote_frontend_path = "${local.remote_home_dir}/apps/todos/frontend"

  local_app_path      = "${path.module}/../../apps/todos"
  local_backend_path  = "${path.module}/../../apps/todos/backend-py"
  local_frontend_path = "${path.module}/../../apps/todos/frontend"
}


resource "aws_spot_instance_request" "todo-list-app" {
  ami                  = var.aws_ec2_ami
  instance_type        = var.aws_ec2_instance_type
  key_name             = aws_key_pair.todo-list.key_name
  security_groups      = [aws_security_group.todo_list_app.name]
  wait_for_fulfillment = true

  connection {
    type  = "ssh"
    user  = local.remote_user
    host  = self.public_dns
    private_key = file(var.ec2_private_key_local_filepath)  # BAD PRACTICE: only works for private keys without password protection!
    # agent = true  # use for best practice instead of private_key (line above)
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
      db_host     = aws_db_instance.todos.address
      db_port     = aws_db_instance.todos.port
      db_name     = aws_db_instance.todos.db_name
      db_user     = aws_db_instance.todos.username
      db_password = aws_db_instance.todos.password
    })
    destination = "${local.remote_backend_path}/.env.prod"
  }

  provisioner "local-exec" {
    working_dir = local.local_frontend_path
    command     = "npm ci; npm run build"
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

resource "aws_key_pair" "todo-list" {
  key_name   = "todo-list-${local.username}"
  public_key = data.local_file.todo-list-public-key.content
}

data "local_file" "todo-list-public-key" {
  filename = var.ec2_public_key_local_filepath
}
