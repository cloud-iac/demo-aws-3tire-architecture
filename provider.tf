provider "aws" {
  region = var.region == null ? "ap-northeast-2" : var.region
}