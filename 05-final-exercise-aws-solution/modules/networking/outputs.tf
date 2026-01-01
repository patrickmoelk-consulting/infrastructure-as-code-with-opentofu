output "db_subnet_group_name" {
  value = aws_db_subnet_group.db.name
}

output "db_security_group_ids" {
  value = [aws_security_group.db.id]
}

output "app_security_group_names" {
  value = [aws_security_group.todo_list_app.name]
}