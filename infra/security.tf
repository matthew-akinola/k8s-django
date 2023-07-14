# security group for alb, to allow acess from anywhere on port 80 & 443.
resource "aws_security_group" "ext-alb-sgs" {
  name        = "ext-alb-sg"
  description = "Allow inbound traffic"
  vpc_id      = module.vpc.vpc_id


  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EXT-ALB-SG"
  }
}