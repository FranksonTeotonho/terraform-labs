#---------------------------------
# Stack variables
#---------------------------------
variable "region" {
  default = "us-east-1"
}

variable "region_id" {
  default = "vir"
}

#---------------------------------
# LC variables
#---------------------------------
variable "lc_image_id" {
  default = "ami-04d29b6f966df1537"
}

variable "lc_instance_type" {
  default = "t2.micro"
}

variable "lc_public_ip_flag" {
  default = true
}

#---------------------------------
# ASG variables
#---------------------------------
variable "asg_max_size" {
  default = 1
}
variable "asg_min_size" {
  default = 1
}
variable "asg_desired_capacity" {
  default = 1
}