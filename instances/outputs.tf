output "bestion_ip" {
  value = aws_instance.bestion.public_ip
}
output "front_private_ip" {
  value = aws_instance.front.private_ip
}
output "back_private_ip" {
  value = aws_instance.backend.private_ip
}