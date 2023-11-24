provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-086cae3329a3f7d75"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.webserversg.id]
  user_data              = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p ${var.service_port} &
  EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }
}

resource "aws_security_group" "webserversg" {
  name = "terraform-example-webserversg"

  ingress {
    from_port   = var.service_port
    to_port     = var.service_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "service_port" {
  description = "Service Port for HTTP Request"
  type        = number
  default     = 8080
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "Public IP for Web Server"
}

output "service_url" {
  value       = "http://${aws_instance.example.public_ip}:${var.service_port}"
  description = "Web Server Service URL"
}
