#Official documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

#Declare the security group itself
resource "aws_security_group" "SG_jump_box" {
  name        = "SG-jump-box" #This is the name in AWS Console
  description = "Security Group for the jump box. Should allow SSH from anywhere for connections."
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "SG-jump-box" #This is an informal name tag for AWS
  }
}

#You can declare rules as individual resources, with attachments made to the security group:
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.SG_jump_box.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

/*
AWS allows all egress by default, but Terraform overrides this!
This means that we need to explicitly allow egress traffic in order 
to use SSH. In general, if we don't add egress rules then no 
TCP traffic can arrive at our device. We are allowing all egress
communication: 
*/

resource "aws_vpc_security_group_egress_rule" "allow_ssh_response" {
  security_group_id = aws_security_group.SG_jump_box.id

  cidr_ipv4   = "0.0.0.0/0"

  ip_protocol = "-1"  # -1 means "all protocols"
}

