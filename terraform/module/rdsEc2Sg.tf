module "ec2_instance" {
  source = "./ec2.tf"
}

module "vpc_subnet" {
  source = "./vpc.tf"
}


resource "aws_db_instance" "mysql_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = "db.t2.micro"
  username               = "rlatkdMySQL"
  password               = "****"
  vpc_security_group_ids = ["default"]
  publicly_accessible    = false
  tags = {
    Name = "rlatkdMySQL"
  }
}
