variable "aws_region" {
  type        = string
  description = "AWS region, e.g. eu-central-1 or us-east-1"
  default     = "eu-central-1"
}

variable "aws_ec2_ami" {
  default = "ami-004e960cde33f9146" // Ubuntu, 24.04
}

variable "aws_ec2_instance_type" {
  default = "t2.micro"
}

variable "ec2_public_key_local_filepath" {
  type = string
}

variable "ec2_private_key_local_filepath" {
  type = string
}


variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_engine" {
  default = "postgres"
}

variable "db_engine_version" {
  default = "17.6"
}

variable "db_name" {
  default = "todos"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  type = string
}

variable "db_storage_in_GiB" {
  default = 10
}

variable "db_storage_type" {
  default = "gp2"
}
