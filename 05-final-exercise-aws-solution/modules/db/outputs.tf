output "host" {
  value = aws_db_instance.todos.address
}

output "port" {
  value = aws_db_instance.todos.port
}

output "db_name" {
  value = aws_db_instance.todos.db_name
}

output "user" {
  value = aws_db_instance.todos.username
}
