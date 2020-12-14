#---------------------------------
# Stack variables
#---------------------------------
variable "region" {
  default = "us-east-1"
}

variable "env" {
  default = "stag"
}

variable "current_color" {
  default = "green"
}

#---------------------------------
# Route53 variables
#---------------------------------
variable "app_cname" {
  default = "app"
}