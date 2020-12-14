#---------------------------------
# Stack variables
#---------------------------------
variable "region" {
  default = "us-east-1"
}

variable "stack_region_id" {
  default = "vir"
}

#---------------------------------
# LC variables
#---------------------------------
variable "stack_lc_image_id" {
  default = "ami-04d29b6f966df1537"
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