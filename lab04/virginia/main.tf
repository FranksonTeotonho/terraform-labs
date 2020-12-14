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

module "my-asg" {
  source               = "../modules/asg"
  region_id            = var.stack_region_id
  lc_image_id          = var.stack_lc_image_id
  asg_max_size         = var.stack_asg_max_size
  asg_min_size         = var.stack_asg_min_size
  asg_desired_capacity = var.stack_asg_desired_capacity
  key_name             = "terraform-${var.stack_region_id}"
  subnet_ids           = [data.aws_subnet.selected_subnet.id]
}