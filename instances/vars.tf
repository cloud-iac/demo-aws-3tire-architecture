variable "ssh-key-path" {
  type = string
}
variable "bestion_sg_ids" {
  type = list(string)
}
variable "bestion_subnet_id" {
  type = string
}
variable "front_sg_ids" {
  type = list(string)
}
variable "front_subnet_id" {
  type = string
}
variable "backend_sg_ids" {
  type = list(string)
}
variable "backend_subnet_id" {
  type = string
}