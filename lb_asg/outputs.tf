output "pub_alb_dns" {
  value = aws_lb.pub-alb.dns_name
}
output "pri_alb_dns" {
  value = aws_lb.pri-alb.dns_name
}