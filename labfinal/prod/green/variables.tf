#---------------------------------
# Stack variables
#---------------------------------
variable "region" {
  default = "us-east-1"
}

variable "env" {
  default = "prod"
}

variable "stack_color" {
  default = "green"
}
#---------------------------------
# ELB Variables
#---------------------------------
variable "stack_elb_healthy_threshold" {
  default = 2
}

variable "stack_elb_unhealthy_threshold" {
  default = 2
}
variable "stack_elb_health_check_target" {
  default = "HTTP:80/"
}

#---------------------------------
# Route53 variables
#---------------------------------
variable "app_cname" {
  default = "app"
}

#---------------------------------
# LC variables
#---------------------------------
variable "stack_lc_image_id" {
  # default = "ami-00ddb0e5626798373"
  default = "ami-04d29b6f966df1537"
}
variable "stack_lc_instance_type" {
  default = "t2.micro"
}
variable "stack_lc_public_ip_flag" {
  default = true
}

variable "stack_key_name" {
  default = "terraform"
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