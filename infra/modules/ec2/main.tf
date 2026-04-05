resource "aws_instance" "this" {
  ami = var.ami
  instance_type = var.instance_type
  user_data = var.user_data
  iam_instance_profile = var.iam_instance_profile
  vpc_security_group_ids = [aws_security_group.this.id]
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }
  tags = {
    Name = var.name
  }
}

resource "aws_security_group" "this" {
  name = "allow-http"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}
