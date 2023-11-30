provider "aws" {
  region = var.region != null ? var.region : "ap-northeast-2"
}