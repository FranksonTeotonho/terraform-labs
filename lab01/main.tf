terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform"
  public_key = file("/home/fsousa/.ssh/terraform.pub")
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-09558250a3419e7d0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-3510b45e"
  key_name      = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Terraform_EC2"
  }
}
