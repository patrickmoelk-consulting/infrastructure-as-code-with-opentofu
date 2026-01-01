variable "aws_ec2_instance_type" {
  default = "t2.micro"
}

variable "public_key_local_filepath" {
  type = string
}

variable "private_key_local_filepath" {
  type = string
}


variable "security_group_names" {
  type = set(string)
}

variable "repo_root" {
  type = string
}


variable "db_host" { type = string }
variable "db_port" { type = string }
variable "db_name" { type = string }
variable "db_user" { type = string }
variable "db_password" { type = string }
