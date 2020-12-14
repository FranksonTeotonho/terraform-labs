#---------------------------------
# Region variables
#---------------------------------
variable "region_id" {}
#---------------------------------
# AWS Key Pair variables
#---------------------------------
variable "key_name" {}
#---------------------------------
# LC variables
#---------------------------------
variable "lc_image_id" {}
variable "lc_instance_type" {
  default = "t2.micro"
}
variable "lc_public_ip_flag" {
  default = true
}

#---------------------------------
# ASG variables
#---------------------------------
variable "asg_max_size" {}
variable "asg_min_size" {}
variable "asg_desired_capacity" {}
variable "subnet_ids" {}