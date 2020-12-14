#---------------------------------
# Data source - VPC
#---------------------------------
data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:Name"
    values = ["terraform-${var.env}-vpc"]
  }
}
#---------------------------------
# SG - Load Balancer
#---------------------------------
resource "aws_security_group" "lb_sg" {
  name   = "terraform-${var.env}-lb-sg"
  vpc_id = data.aws_vpc.selected_vpc.id
}

# Inbound
resource "aws_security_group_rule" "lb_sg_http_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
}

# Outbound
resource "aws_security_group_rule" "lb_sg_http_outbound" {
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.ec2_sg.id
  security_group_id        = aws_security_group.lb_sg.id
}

#---------------------------------
# SG - EC2
#---------------------------------
resource "aws_security_group" "ec2_sg" {
  name   = "terraform-${var.env}-ec2-sg"
  vpc_id = data.aws_vpc.selected_vpc.id
}

# Inbound
resource "aws_security_group_rule" "ec2_sg_http_inbound" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.lb_sg.id
  security_group_id        = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ec2_sg_ssh_inbound" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

# Outbound
resource "aws_security_group_rule" "ec2_sg_http_outbound" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}