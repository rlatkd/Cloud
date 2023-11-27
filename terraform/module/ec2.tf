resource "aws_instance" "example_ec2_instance" {
  ami                  = "ami-086cae3329a3f7d75"
  instance_type        = "t2.micro"
  subnet_id            = "subnet-xxxxxxxxxxxxxxxxx"
  key_name             = "rlatkdKeyPair"
  iam_instance_profile = aws_iam_instance_profile.example_profile.name
}

# role.tf 파일에서 생성한 IAM 역할과 EC2 인스턴스를 연결하기 위한 IAM 인스턴스 프로필을 생성합니다.
resource "aws_iam_instance_profile" "rlatkdWebServer" {
  name = "example_instance_profile"
  role = aws_iam_role.rlatkdEC2AccessS3Role.name # role.tf 파일에서 생성한 IAM 역할을 참조하여 연결합니다.
}

