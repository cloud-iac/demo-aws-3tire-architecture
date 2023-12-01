variable "security_groups" {type = map(string)}
variable "routing_tables" {type = map(string)}
variable "nat_gw_id" {type = string}
variable "igw_id" {type = string}
variable "ingress_alb_pub" {
  default = {
    80 = {
      type        = "ingress"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    443 = {
      type        = "ingress"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "ingress_bestion" {
  default = {
    22 = {
      type        = "ingress"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  }
}

variable "ingress_alb_pri" {
  default = {
    80 = {
      type        = "ingress"
      protocol    = "tcp"
    },
    443 = {
      type        = "ingress"
      protocol    = "tcp"
    }
  }
}

variable "ingress_front" {
  default = {
    80 = {
      type        = "ingress"
      protocol    = "tcp"
    },
    443 = {
      type        = "ingress"
      protocol    = "tcp"
    },
    3000 = {
      type        = "ingress"
      protocol    = "tcp"
    },
  }
}

variable "ingress_back" {
  default = {
    80 = {
      type        = "ingress"
      protocol    = "tcp"
    },
    443 = {
      type        = "ingress"
      protocol    = "tcp"
    },
    8080 = {
      type        = "ingress"
      protocol    = "tcp"
    }
  }
}
variable "ingress_db" {
  default = {
    3306 = {
      type        = "ingress"
      protocol    = "tcp"
    },
  }
}