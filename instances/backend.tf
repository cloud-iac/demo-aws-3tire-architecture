resource "aws_instance" "backend" {
  ami                    = "ami-09e70258ddbdf3c90"
  instance_type          = "t2.micro"
  key_name               = "aws-ec2"
  subnet_id              = var.backend_subnet_id
  vpc_security_group_ids = var.backend_sg_ids
  private_ip             = "10.0.3.100"
  user_data = <<EOT
  #!/bin/bash
  yum update -y
  yum install -y docker docker-registry
  systemctl start docker.service
  systemctl enable docker.service
  EOT
  tags = {
    Name = "backend"
  }
}