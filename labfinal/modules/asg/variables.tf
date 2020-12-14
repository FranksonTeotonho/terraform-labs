#---------------------------------
# Stack variables
#---------------------------------
variable "env" {}
variable "color" {}
#---------------------------------
# LC variables
#---------------------------------
variable "lc_name_prefix" {}
variable "lc_image_id" {}
variable "lc_instance_type" {}
variable "lc_public_ip_flag" {}
variable "lc_security_groups_id" {}
variable "lc_key_name" {}

#---------------------------------
# ASG variables
#---------------------------------
variable "asg_name" {}
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "asg_desired_capacity" {}
variable "asg_subnet_ids" {}
variable "asg_load_balancer_name" {}