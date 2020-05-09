resource "aws_security_group" "appserver-securitygroup" {
  vpc_id      = module.main-vpc.vpc_id
  name        = "appserver-securitygroup"
  description = "security group that allows ssh, rdp and all egress traffic to the appserver"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.workstation-external-cidr]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [local.workstation-external-cidr]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "appserver-securitygroup"
    "Project Name" = var.AWS_PROJECT_NAME
  }
}
