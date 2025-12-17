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
