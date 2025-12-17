resource "aws_spot_instance_request" "todo-list-app" {
  ami                  = var.aws_ec2_ami
  instance_type        = var.aws_ec2_instance_type
  key_name             = aws_key_pair.todo-list.key_name
  security_groups      = [aws_security_group.todo_list_app.name]
  wait_for_fulfillment = true

  connection {
    type  = "ssh"
    user  = "ubuntu"
    host  = self.public_dns
    agent = true
  }

  provisioner "remote-exec" {
    inline = ["mkdir -p /home/ubuntu/apps/todos"]
  }

  provisioner "file" {
    source      = "${path.module}/../../apps/backend/todos"
    destination = "/home/ubuntu/apps/todos/backend"
  }

  provisioner "file" {
    content = templatefile("${path.module}/../../apps/backend/todos/.env.prod.tftpl", {
      db_host     = aws_db_instance.todos.address
      db_port     = aws_db_instance.todos.port
      db_name     = aws_db_instance.todos.db_name
      db_user     = aws_db_instance.todos.username
      db_password = aws_db_instance.todos.password
    })
    destination = "/home/ubuntu/apps/todos/backend/.env.prod"
  }

  provisioner "local-exec" {
    working_dir = "${path.module}/../../apps/frontend/todos"
    command     = "npm run build"
  }

  provisioner "file" {
    source      = "${path.module}/../../apps/frontend/todos/dist"
    destination = "/home/ubuntu/apps/todos/frontend"
  }

  provisioner "file" {
    source      = "${path.module}/todo-list-app-backend.service"
    destination = "/home/ubuntu/apps/todos/todo-list-app-backend.service"
  }

  provisioner "file" {
    source      = "${path.module}/../../apps/Caddyfile.prod"
    destination = "/home/ubuntu/apps/todos/Caddyfile"
  }

  provisioner "remote-exec" {
    script = "${path.module}/init-script.sh"
  }
}

resource "aws_key_pair" "todo-list" {
  key_name   = "todo-list"
  public_key = data.local_file.todo-list-public-key.content
}

data "local_file" "todo-list-public-key" {
  filename = "/Users/patrick/.ssh/aws-iac-workshop.ed25519.pub"
}

