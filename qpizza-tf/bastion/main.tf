resource "tls_private_key" "that" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "that" {
  key_name   = var.key_name
  public_key = tls_private_key.that.public_key_openssh
}

resource "aws_security_group" "bastion_sg" {
  description = "Security group for Bastion"
  vpc_id = var.vpc_id
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ssm_parameter" "ami_id" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-arm64"
}


resource "aws_instance" "bastion" {
  ami           = data.aws_ssm_parameter.ami_id.value
  instance_type = var.bastion_instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  key_name = aws_key_pair.that.key_name
  user_data = <<EOF
  #!/bin/bash
  yum -y install mariadb105
  EOF
}

