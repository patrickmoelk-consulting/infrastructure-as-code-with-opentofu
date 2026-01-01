resource "aws_db_instance" "todos" {
  instance_class             = var.instance_class
  engine                     = var.engine
  engine_version             = var.engine_version
  auto_minor_version_upgrade = true

  db_name  = var.name
  username = var.username
  password = var.password

  allocated_storage = var.storage_in_GiB
  storage_type      = var.storage_type
  storage_encrypted = true

  publicly_accessible    = false
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = var.subnet_group_name

  skip_final_snapshot = true
}
