data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  region = var.aws_region
}


///////////////////////////////////////////////////////////
// EC2 Security Group
///////////////////////////////////////////////////////////
resource "aws_security_group" "todo_list_app" {
  vpc_id = data.aws_vpc.default.id
  name   = "Todo list app"
}

// allow SSH from local IP only
resource "aws_vpc_security_group_ingress_rule" "todo_list_app_ssh" {
  security_group_id = aws_security_group.todo_list_app.id
  cidr_ipv4         = "${replace(data.local_command.my_ip_v4.stdout, "\n", "")}/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

data "local_command" "my_ip_v4" {
  command   = "curl"
  arguments = ["-4", "https://icanhazip.com"]
}


// allow HTTP / HTTPS ingress from anywhere (IPv4 and IPv6)
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

// allow egress to anywhere (IPv4 and IPv6)
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


///////////////////////////////////////////////////////////
// Database Security Group
///////////////////////////////////////////////////////////
resource "aws_security_group" "db" {
  vpc_id = data.aws_vpc.default.id
  name   = "databases"
}

// allow access only from todo list app security group, only on port 5432
resource "aws_vpc_security_group_ingress_rule" "db_ingress_from_app" {
  security_group_id            = aws_security_group.db.id
  referenced_security_group_id = aws_security_group.todo_list_app.id

  from_port   = 5432
  to_port     = 5432
  ip_protocol = "tcp"
}

resource "aws_db_subnet_group" "db" {
  name       = "databases"
  subnet_ids = data.aws_subnets.default.ids
}
