resource "aws_security_group" "payment_app" {
  name        = "payment_app"
  description = "Application Security Group"
  depends_on  = [aws_eip.example]

  # Below 
  ingress {
    description = "Allow HTTPS access from DEV VPC"
    from_port   = var.https
    to_port     = var.https
    protocol    = "tcp"
    cidr_blocks = ["${var.dev_vpc_cidr}"]
  }

  # Below ingress allows APIs access from DEV VPC

  ingress {
    description = "Allow API access from DEV VPC"
    from_port   = var.api
    to_port     = var.api
    protocol    = "tcp"
    cidr_blocks = ["${var.dev_vpc_cidr}"]
  }

  # Below ingress allows APIs access from Prod App Public IP.

  ingress {
    description = "Allow API access from Prod App Public IP"
    from_port   = var.prod_app_ip
    to_port     = var.prod_app_ip
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.example.public_ip}/32"]
  }

  egress {
    from_port   = var.splunk
    to_port     = var.splunk
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "payment_app"
    Team = "DevOps"
    Environment = "Dev"
  }
}