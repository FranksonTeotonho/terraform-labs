#---------------------------------
# User data template
#---------------------------------
data "template_file" "userdata" {
  template = file("${path.module}/scripts/userdata.tpl")

  vars = {
    environment = var.env
    color_id    = var.color
  }
}

#---------------------------------
# Launch Configuration
#---------------------------------
resource "aws_launch_configuration" "lc" {
  name_prefix                 = var.lc_name_prefix
  image_id                    = var.lc_image_id
  instance_type               = var.lc_instance_type
  security_groups             = [var.lc_security_groups_id]
  key_name                    = var.lc_key_name
  user_data                   = data.template_file.userdata.rendered
}

#---------------------------------
# Auto Scaling Group
#---------------------------------
resource "aws_autoscaling_group" "asg" {
  name                 = var.asg_name
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = var.asg_subnet_ids
  load_balancers       = [var.asg_load_balancer_name]
  launch_configuration = aws_launch_configuration.lc.name

  tag {
    key                 = "Name"
    value               = "terraform-${var.color}-${var.env}-ec2"
    propagate_at_launch = true
  }
}