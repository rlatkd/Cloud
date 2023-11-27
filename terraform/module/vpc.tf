# VPC 생성
resource "aws_vpc" "rlatkdVPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "rlatkdVPC"
  }
}


# 첫 번째 가용 영역에 퍼블릭 서브넷 생성
resource "aws_subnet" "rlatkdVPC-subnet-public1-ap-northeast-2a" {
  vpc_id                  = aws_vpc.rlatkdVPC.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "rlatkdVPC-subnet-public1-ap-northeast-2a"
  }
}


# 두 번째 가용 영역에 퍼블릭 서브넷 생성
resource "aws_subnet" "rlatkdVPC-subnet-public2-ap-northeast-2a" {
  vpc_id                  = aws_vpc.rlatkdVPC.id
  cidr_block              = "10.0.16.0.20"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "rlatkdVPC-subnet-public2-ap-northeast-2a"
  }
}


# 첫 번째 가용 영역에 프라이빗 서브넷 생성
resource "aws_subnet" "rlatkdVPC-subnet-private1-ap-northeast-2a" {
  vpc_id            = aws_vpc.rlatkdVPC.id
  cidr_block        = "10.0.128.0/20"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "rlatkdVPC-subnet-private1-ap-northeast-2a"
  }
}


# 두 번째 가용 영역에 프라이빗 서브넷 생성
resource "aws_subnet" "rlatkdVPC-subnet-private2-ap-northeast-2a" {
  vpc_id            = aws_vpc.rlatkdVPC.id
  cidr_block        = "10.0.144.0/20"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "rlatkdVPC-subnet-private2-ap-northeast-2a"
  }
}


# 인터넷 게이트웨이 생성 (퍼블릭용)
resource "aws_internet_gateway" "rlatkdVPC-igw" {
  vpc_id = aws_vpc.rlatkdVPC.id
  tags = {
    Name = "rlatkdVPC-igw"
  }
}


# VPC에 대한 라우팅 테이블 생성 및 인터넷 게이트웨이 연결 (퍼블릭용)
resource "aws_route_table" "rlatkdVPC-rtb-public" {
  vpc_id = aws_vpc.rlatkdVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rlatkdVPC-igw.id
  }
  tags = {
    Name = "rlatkdVPC-rtb-public"
  }
}


# VPC에 대한 라우팅 테이블 생성 (프라이빗용)
resource "aws_route_table" "rlatkdVPC-rtb-private1-ap-northeast-2a" {
  vpc_id = aws_vpc.rlatkdVPC.id
  tags = {
    Name = "rlatkdVPC-rtb-private1-ap-northeast-2a"
  }
}

resource "aws_route_table" "rlatkdVPC-rtb-private2-ap-northeast-2a" {
  vpc_id = aws_vpc.rlatkdVPC.id
  tags = {
    Name = "rlatkdVPC-rtb-private2-ap-northeast-2a"
  }
}


# 퍼블릭 서브넷에 라우팅 테이블 연결
resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id      = aws_subnet.rlatkdVPC-subnet-public1-ap-northeast-2a.id
  route_table_id = aws_route_table.rlatkdVPC-rtb-public.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id      = aws_subnet.rlatkdVPC-subnet-public2-ap-northeast-2a.id
  route_table_id = aws_route_table.rlatkdVPC-rtb-public.id
}


# 프라이빗 서브넷에 라우팅 테이블 연결
resource "aws_route_table_association" "private_subnet_association_1" {
  subnet_id      = aws_subnet.rlatkdVPC-subnet-private1-ap-northeast-2a.id
  route_table_id = aws_route_table.rlatkdVPC-rtb-private1-ap-northeast-2a.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id      = aws_subnet.rlatkdVPC-subnet-private2-ap-northeast-2a.id
  route_table_id = aws_route_table.rlatkdVPC-rtb-private2-ap-northeast-2a.id
}
