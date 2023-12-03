output "bestion_ip" {
  value = aws_instance.bestion.public_ip
}
output "front_template_id" {
  value = aws_launch_template.front_template.id
}
output "back_template_id" {
  value = aws_launch_template.back_template.id
}