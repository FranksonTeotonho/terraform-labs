#---------------------------------
# Stack Variables
#---------------------------------
variable "env" {}
#---------------------------------
# ELB Variables
#---------------------------------
variable "elb_name" {}
variable "elb_subnet_ids" {}
variable "elb_healthy_threshold" {}
variable "elb_unhealthy_threshold" {}
variable "elb_health_check_target" {}
variable "elb_security_groups_id" {}