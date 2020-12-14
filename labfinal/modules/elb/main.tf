#---------------------------------
# ELB
#---------------------------------
resource "aws_elb" "my_elb" {
  name            = var.elb_name
  internal        = false
  subnets         = var.elb_subnet_ids
  security_groups = [var.elb_security_groups_id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = var.elb_healthy_threshold
    unhealthy_threshold = var.elb_unhealthy_threshold
    interval            = 30
    target              = var.elb_health_check_target
    timeout             = 5
  }

  tags = {
    Name = "terraform-${var.env}-lb"
  }
}