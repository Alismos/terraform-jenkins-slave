terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}


provider "aws" {
  region = "us-west-1"
}

# EC2 instances details
resource "aws_instance" "slave" {
  count                  = 1
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = element([var.subnet_instance, var.subnet_instance_b], count.index)
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.slave_sg.id]

  tags = {
    Name        = "ms-slave"
    responsible = var.responsible
    project     = var.project
  }

  volume_tags = {
    responsible = var.responsible
    project     = var.project
  }
}