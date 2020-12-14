#---------------------------------
# Stack variables
#---------------------------------
variable "region" {
  default = "us-east-2"
}

variable "stack_region_id" {
  default = "ohio"
}

#---------------------------------
# LC variables
#---------------------------------
variable "stack_lc_image_id" {
  default = "ami-09558250a3419e7d0"
}

#---------------------------------
# ASG variables
#---------------------------------
variable "stack_asg_max_size" {
  default = 1
}
variable "stack_asg_min_size" {
  default = 1
}
variable "stack_asg_desired_capacity" {
  default = 1
}