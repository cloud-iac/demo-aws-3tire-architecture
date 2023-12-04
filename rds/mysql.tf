resource "aws_db_subnet_group" "db_sn_group" {
  name       = "db-subent-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "pri_db_sn_group"
  }
}
resource "aws_db_instance" "mysql" {
  identifier           = "mysql"
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  allocated_storage    = 10
  db_name = var.db_name
  skip_final_snapshot = true
  username             = var.username
  password             = var.password
  publicly_accessible = false
  vpc_security_group_ids = var.db_sg_ids
  db_subnet_group_name = aws_db_subnet_group.db_sn_group.name
}
