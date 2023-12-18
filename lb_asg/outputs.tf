output "pub_alb_dns" {
  value = aws_lb.pub-alb.dns_name
}
output "pri_alb_dns" {
  value = aws_lb.pri-alb.dns_name
}
output "pub_zone_id" {
  value = aws_lb.pub-alb.zone_id
}
output "pri_zone_id" {
  value = aws_lb.pri-alb.zone_id
}