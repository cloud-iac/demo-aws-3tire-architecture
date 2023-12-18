output "db_dns" {
  value = aws_db_instance.mysql.endpoint
}