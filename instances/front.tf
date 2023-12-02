resource "aws_instance" "front" {
  ami                    = "ami-09e70258ddbdf3c90"
  instance_type          = "t2.micro"
  key_name               = "aws-ec2"
  subnet_id              = var.front_subnet_id
  vpc_security_group_ids = var.front_sg_ids
  private_ip             = "10.0.2.100"
  user_data = <<EOT
  #!/bin/bash
  yum update -y
  yum install -y docker docker-registry
  systemctl start docker.service
  systemctl enable docker.service
  EOT
  tags = {
    Name = "front"
  }
}