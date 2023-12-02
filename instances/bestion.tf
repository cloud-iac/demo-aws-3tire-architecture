provider "null" {}
resource "aws_instance" "bestion" {
  ami                         = "ami-09e70258ddbdf3c90"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "aws-ec2"
  subnet_id                   = var.bestion_subnet_id
  vpc_security_group_ids      = var.bestion_sg_ids
  private_ip                  = "10.0.1.100"

  tags = {
    Name = "bestion"
  }
}
resource "null_resource" "scp" {
  provisioner "local-exec" {
    command = "sleep 10;scp -i ~/.ssh/aws_ec2.pem ~/.ssh/aws_ec2.pem ec2-user@${aws_instance.bestion.public_ip}:~/.ssh/aws_ec2.pem"
  }
}
