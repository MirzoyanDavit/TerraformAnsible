provider "aws" {}

resource "aws_security_group" "group" {
  
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Nginx HTTP"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "group"
  }
}

resource "aws_instance" "ec2_1" {
  ami           = "ami-04a0530fbdaac2fd6"
  instance_type = "t3.micro"
  key_name               = "terraform-ansible-key"


  vpc_security_group_ids = [ aws_security_group.group.id ]
  user_data_replace_on_change = true

  tags = {
    Name = "ubuntu1"
  }
}

resource "aws_instance" "ec2_2" {
  ami           = "ami-04a0530fbdaac2fd6"
  instance_type = "t3.micro"
  key_name               = "terraform-ansible-key"


  vpc_security_group_ids = [ aws_security_group.group.id ]
  user_data_replace_on_change = true

  tags = {
    Name = "ubuntu2"
  }
}

output "public_ip_1" {
  value       = aws_instance.ec2_1.public_ip
}

output "public_ip_2" {
  value       = aws_instance.ec2_2.public_ip
}