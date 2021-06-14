locals {
  vpc_id           = "vpc-dce668a1"
  subnet_id        = "subnet-78730c27"
  ssh_user         = "ec2-user"
  key_name         = "poc-account"
  private_key_path = "/Users/Aditya/Downloads/poc-account.pem"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "mediawiki" {
  name   = "mediawiki_access"
  vpc_id = local.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "mediawiki" {
  ami                         = "ami-0b0af3577fe5e3532"
  subnet_id                   = "subnet-78730c27"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.mediawiki.id]
  key_name                    = local.key_name

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.mediawiki.public_ip
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.mediawiki.public_ip}, --private-key ${local.private_key_path} mediawiki.yml"
  }
}

output "mediawiki_ip" {
  value = aws_instance.mediawiki.public_ip
}
