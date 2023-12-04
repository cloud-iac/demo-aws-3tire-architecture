variable "username" {type = string}
variable "password" {type = string}
variable "subnet_ids" {type = list(string)}
variable "db_sg_ids" {type = list(string)}
variable "db_name" {type = string}