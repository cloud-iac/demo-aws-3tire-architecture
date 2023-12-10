resource "aws_launch_template" "front_template" {
  name                   = "front_template"
  image_id               = "ami-09e70258ddbdf3c90"
  instance_type          = "t2.micro"
  key_name               = "aws-ec2"
  vpc_security_group_ids = var.front_sg_ids
  update_default_version = true

  user_data = base64encode(
    <<EOT
    #!/bin/bash
    yum update -y
    yum install -y docker docker-registry
    systemctl start docker.service
    systemctl enable docker.service

    docker pull lundaljung/demo-ci-cd-frontend:latest
    docker run -d --name frontend -p 80:80 lundaljung/demo-ci-cd-frontend:latest
    EOT 
  )
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "front_template"
  }
}