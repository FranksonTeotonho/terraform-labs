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
    name   = "tag:Name"
    values = ["selected_subnet"]
  }
}

#---------------------------------
# AWS Key Pair
#---------------------------------
resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform-${var.region_id}"
  public_key = file("/home/fsousa/.ssh/terraform.pub")
}

#---------------------------------
# Launch Configuration
#---------------------------------
resource "aws_launch_configuration" "lc" {
  name_prefix   = "lc-${var.region_id}"
  image_id      = var.lc_image_id
  instance_type = var.lc_instance_type
  key_name      = aws_key_pair.ssh_key.key_name
}

#---------------------------------
# Auto Scaling Group
#---------------------------------
resource "aws_autoscaling_group" "asg" {
  name                 = "asg-${var.region_id}"
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = [data.aws_subnet.selected_subnet.id]
  launch_configuration = aws_launch_configuration.lc.name

  tag {
    key                 = "Name"
    value               = "terraform-ec2-${var.region_id}"
    propagate_at_launch = true
  }
}