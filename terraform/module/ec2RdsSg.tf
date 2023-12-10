resource "local_file" "private_key" {
  filename = "C:/Users/User/Desktop/프로젝트/rlatkdKeyPair.pem"
  content  = tls_private_key.private-key.private_key_pem
}

module "vpc_subnet" {
  source = "./vpc.tf"
}

module "security_group" {
  source = "./ec2Sg.tf"
}

resource "aws_instance" "rlatkdWebServer" {
  ami                         = "ami-086cae3329a3f7d75"
  instance_type               = "t2.micro"
  key_name                    = module.keypair.rlatkdKeyPair.key_name
  subnet_id                   = module.vpc_subnet.aws_subnet.rlatkdVPC-subnet-public-ap-northeast-2a.id
  associate_public_ip_address = true
  security_groups             = [module.security_group.aws_security_group.rlatkdFlaskWebServerSg.id]
  tags = {
    Name = "rlatkdWebServer"
  }
}
