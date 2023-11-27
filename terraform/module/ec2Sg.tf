# rlatkdFlaskWebServserSg

resource "aws_security_group" "rlatkdFlaskWebServerSg" {
  name        = "rlatkdFlaskWebServerSg"
  description = "Security group for Flask web server"
  vpc_id      = aws_vpc.rlatkdVPC.id


  # 인바운드 규칙 설정
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Flask traffic"
  }
}
