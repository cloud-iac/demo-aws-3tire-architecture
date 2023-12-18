data "aws_route53_zone" "selected" {
  name         = "lundaljung.com."
  private_zone = false
}
resource "aws_route53_zone" "private" {
  name = "inter-lundaljung.com"
  vpc {
    vpc_id = var.vpc_id
  }
}
resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.private.zone_id
  name = "db.inter-lundaljung.com"
  type = "CNAME"
  ttl = 300
  records = [var.db_dns]
}
resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.private.zone_id
  name = "api.inter-lundaljung.com"
  type = "A"
  alias {
    name                   = var.inter_alb_dns
    zone_id                = var.pri_alb_zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "www.lundaljung.com"
  type = "A"
  alias {
    name                   = var.public_alb_dns
    zone_id                = var.pub_alb_zone_id
    evaluate_target_health = true
  }
}
resource "aws_route53_record" "public" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "lundaljung.com"
  type = "A"
  alias {
    name                   = var.public_alb_dns
    zone_id                = var.pub_alb_zone_id
    evaluate_target_health = true
  }
}

