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


variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  type = string
}
