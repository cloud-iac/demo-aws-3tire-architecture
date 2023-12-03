variable "vpc_id" {
  type = string
}

variable "front_subnets" {
  type = list(string)
}
variable "pub_alb_subnets" {
  type = list(string)
}
variable "pub_alb_sg_groups" {
  type = list(string)
}
variable "front_template_id" {
  type = string
}

variable "back_subnets" {
  type = list(string)
}
variable "pri_alb_subnets" {
  type = list(string)
}
variable "pri_alb_sg_groups" {
  type = list(string)
}
variable "back_template_id" {
  type = string
}