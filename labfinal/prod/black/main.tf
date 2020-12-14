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
# Route53 Black
#---------------------------------
module "route53" {
  source      = "../../modules/route_53"
  cname       = "${var.app_cname}.${var.env}"
  dns_name    = "${var.app_cname}.${var.current_color}.${var.env}.franksonteotonho.link"
  hosted_zone = "franksonteotonho.link"
}

#---------------------------------
# Network infrastructure
#---------------------------------
module "my_network_infra" {
  source = "../../modules/network"
  env    = var.env
}

#---------------------------------
# Security Groups
#---------------------------------
module "sg_modules" {
  source = "../../modules/security_groups"
  env    = var.env
  depends_on = [module.my_network_infra]
}

#---------------------------------
# AWS Key Pair
#---------------------------------
resource "aws_key_pair" "ssh_key" {
  key_name   = "terraform"
  public_key = file("/home/fsousa/.ssh/terraform.pub")
}
