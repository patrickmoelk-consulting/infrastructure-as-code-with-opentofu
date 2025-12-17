resource "aws_db_instance" "todos" {
  instance_class             = "db.t3.micro"
  engine                     = "postgres"
  engine_version             = "17.6"
  auto_minor_version_upgrade = true

  db_name  = "todos"
  username = var.db_username
  password = var.db_password

  allocated_storage = 10
  storage_encrypted = true
  storage_type      = "gp2"

  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db.id]

  db_subnet_group_name      = aws_db_subnet_group.db.name
  skip_final_snapshot       = true
}

resource "aws_security_group" "db" {
  vpc_id = data.aws_vpc.default.id
  name   = "databases"
}

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


data "aws_subnets" "default" {
  region = "eu-central-1"
}

output "subnets" {
  value = data.aws_subnets.default
}

output "rds_endpoint" {
  value = aws_db_instance.todos.endpoint
}

output "rds_domain" {
  value = aws_db_instance.todos.address
}