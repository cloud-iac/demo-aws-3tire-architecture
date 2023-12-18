resource "aws_instance" "bestion" {
  ami                         = "ami-09e70258ddbdf3c90"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = var.ssh-key
  subnet_id                   = var.bestion_subnet_id
  vpc_security_group_ids      = var.bestion_sg_ids
  private_ip                  = "10.0.1.100"

  user_data = <<-EOF
  #!/bin/bash
  echo "${file("./${var.ssh-key}.pem")}" > /home/ec2-user/"${var.ssh-key}.pem"
  chmod 600 /home/ec2-user/"${var.ssh-key}.pem"
  EOF
  tags = {
    Name = "bestion"
  }
}
#bastion-eip
resource "aws_eip" "betion_eip" {
  instance = aws_instance.bestion.id
  tags = {
    Name = "betion_eip"
  }
}
