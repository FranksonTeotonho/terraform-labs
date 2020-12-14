terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  region = var.region
}

#---------------------------------
# Data Source - Subnet
#---------------------------------
data "aws_subnet" "selected_subnet" {
  filter {
    name = "tag:Name"
    values = ["selected_subnet"]
  }
}

data "aws_ami" "my_ami" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["*Amazon Linux*"]
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform"
  public_key = file("/home/fsousa/.ssh/terraform.pub")
}

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.my_ami.id
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.selected_subnet.id
  key_name      = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "Terraform_EC2"
  }
}

#---------------------------------
# Output - Public Ip
#---------------------------------
output "my_public_ip" {
  value = aws_instance.my_ec2.public_ip
}