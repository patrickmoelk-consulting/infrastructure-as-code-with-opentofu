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

output "ec2_ip" {
  value = aws_spot_instance_request.todo-list-app.public_ip
}

output "ec2_domain" {
  value = aws_spot_instance_request.todo-list-app.public_dns
}


resource "aws_security_group" "todo_list_app" {
  vpc_id = data.aws_vpc.default.id
  name   = "Todo list app"
}

resource "aws_vpc_security_group_ingress_rule" "todo_list_app_ssh" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv4         = "${replace(data.local_command.my_ip_v4.stdout, "\n", "")}/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "todo_list_app_http_ipv4" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "todo_list_app_http_ipv6" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv6         = "::/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "todo_list_app_https_ipv4" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "todo_list_app_https_ipv6" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all_out_ipv4" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "all_out_ipv6" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}


data "local_command" "my_ip_v4" {
  command   = "curl"
  arguments = ["-4", "https://icanhazip.com"]
}

resource "aws_key_pair" "todo-list" {
  key_name   = "todo-list"
  public_key = data.local_file.todo-list-public-key.content
}

data "local_file" "todo-list-public-key" {
  filename = "/Users/patrick/.ssh/aws-iac-workshop.ed25519.pub"
}
