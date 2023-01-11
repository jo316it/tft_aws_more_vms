resource "aws_key_pair" "this" {

  key_name   = "${var.application_name}-key-pair"
  public_key = file("./modules/ec2/keys/rancher_aws.pub")


}


resource "aws_security_group" "juice_sg_ssh" {

  name   = "${var.application_name}-juice-sg-ssh"
  vpc_id = var.vpc_id
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "Access SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }


}

resource "aws_instance" "this" {

  ami                         = "ami-0b93ce03dcbcb10f6"
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.this.key_name
  count                       = var.quantity
  security_groups             = [aws_security_group.juice_sg_ssh.id]
  user_data                   = <<-EOF
                                #! /bin/bash
                                touch /tmp/install.log &&
                                echo "Iniciou" >> /tmp/install.log &&
                                sudo apt update -y &&
                                curl https://releases.rancher.com/install-docker/19.03.sh | sh &&
                                sudo usermod -aG docker ubuntu &&
                                sudo reboot
                                EOF
  tags = {
    "Name" = "${var.application_name}-${count.index}"
  }

}