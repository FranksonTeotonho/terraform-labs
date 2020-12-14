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
# Data source - VPC
#---------------------------------
data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:Name"
    values = ["terraform-${var.env}-vpc"]
  }
}

#---------------------------------
# Data source - public subnets
#---------------------------------
data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.selected_vpc.id
  filter {
    name   = "tag:Name"
    values = ["terraform-${var.env}-public-subnet-*"]
  }
}

#---------------------------------
# Data source - Load Balancer SG
#---------------------------------
data "aws_security_group" "lb_sg" {
  name = "terraform-${var.env}-lb-sg"
}
#---------------------------------
# Data source - EC2 SG
#---------------------------------
data "aws_security_group" "ec2_sg" {
  name = "terraform-${var.env}-ec2-sg"
}


#---------------------------------
# Elastic Load Balancer Module
#---------------------------------
module "my_elb" {
  source                  = "../../modules/elb"
  env                     = var.env
  elb_name                = "default-elb-${var.env}-${var.stack_color}"
  elb_health_check_target = var.stack_elb_health_check_target
  elb_healthy_threshold   = var.stack_elb_healthy_threshold
  elb_unhealthy_threshold = var.stack_elb_unhealthy_threshold
  elb_subnet_ids          = data.aws_subnet_ids.public_subnets.ids
  elb_security_groups_id  = data.aws_security_group.lb_sg.id
}

#---------------------------------
# Route53 Blue
#---------------------------------
module "route53" {
  source      = "../../modules/route_53"
  cname       = "${var.app_cname}.${var.stack_color}.${var.env}"
  dns_name    = module.my_elb.dns_name
  hosted_zone = "franksonteotonho.link"
}

#---------------------------------
# Auto Scaling Group Module
#---------------------------------
module "my_asg" {
  source                 = "../../modules/asg"
  env                    = var.env
  color                  = var.stack_color
  lc_name_prefix         = "default-lc-${var.env}-${var.stack_color}"
  lc_image_id            = var.stack_lc_image_id
  lc_instance_type       = var.stack_lc_instance_type
  lc_public_ip_flag      = var.stack_lc_public_ip_flag
  lc_security_groups_id  = data.aws_security_group.ec2_sg.id
  lc_key_name            = var.stack_key_name
  asg_name               = "default-asg-${var.env}-${var.stack_color}"
  asg_max_size           = var.stack_asg_max_size
  asg_min_size           = var.stack_asg_min_size
  asg_desired_capacity   = var.stack_asg_desired_capacity
  asg_subnet_ids         = data.aws_subnet_ids.public_subnets.ids
  asg_load_balancer_name = module.my_elb.name
}