resource "aws_db_instance" "todos" {
  instance_class             = var.db_instance_class
  engine                     = var.db_engine
  engine_version             = var.db_engine_version
  auto_minor_version_upgrade = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  allocated_storage = var.db_storage_in_GiB
  storage_type      = var.db_storage_type
  storage_encrypted = true

  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name   = aws_db_subnet_group.db.name

  skip_final_snapshot = true
}
