variable "instance_class" {
  default = "db.t3.micro"
}

variable "engine" {
  default = "postgres"
}

variable "engine_version" {
  default = "17.6"
}

variable "name" {
  default = "todos"
}

variable "username" {
  default = "postgres"
}

variable "password" {
  type      = string
  sensitive = true
}

variable "storage_in_GiB" {
  default = 10
}

variable "storage_type" {
  default = "gp2"
}

variable "subnet_group_name" {
  type = string
}

variable "security_group_ids" {
  type = set(string)
}
