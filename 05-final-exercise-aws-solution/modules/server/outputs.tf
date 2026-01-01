output "ec2_ip" {
  value = aws_spot_instance_request.todo-list-app.public_ip
}

output "ec2_domain" {
  value = aws_spot_instance_request.todo-list-app.public_dns
}
