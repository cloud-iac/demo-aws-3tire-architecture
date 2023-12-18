provider "aws" {
  region     = var.region == null ? "ap-northeast-2" : var.region
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}