# vi main.tf
provider "aws" {
  region = "ap-northeast-2"
}

### vpc start ###

resource "aws_vpc" "test_vpc" {
  cidr_block  = "10.74.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "my-pub_2a" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.0.0/20"   # 앞에서 정의한 "10.74.0.0/16"를 쪼갠 것
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[0]    # ap-northeast-2a -> 숫자는 az순서대로 0, 1, 2 -> a, b, c를 가리킴
  tags = {
    Name = "my-pub-2a"
  }
}

resource "aws_subnet" "my-pub_2b" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.16.0/20"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[1]   # ap-northeast-2b
  tags = {
    Name = "my-pub-2b"
  }
}

resource "aws_subnet" "my-pub_2c" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.32.0/20"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[2]   # ap-northeast-2c
  tags = {
    Name = "my-pub-2c"
  }
}

resource "aws_subnet" "my-pub_2d" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.48.0/20"
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[3]   # ap-northeast-2d
  tags = {
    Name = "my-pub-2d"
  }
}

resource "aws_subnet" "my-pvt_2a" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.64.0/20"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "my-pvt-2a"
  }
}

resource "aws_subnet" "my-pvt_2b" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.80.0/20"
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "my-pvt-2b"
  }
}

resource "aws_subnet" "my-pvt_2c" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.96.0/20"
  availability_zone = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "my-pvt-2c"
  }
}

resource "aws_subnet" "my-pvt_2d" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.74.112.0/20"
  availability_zone = data.aws_availability_zones.available.names[3]
  tags = {
    Name = "my-pvt-2d"
  }
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "test_pub_rtb" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }
  tags = {
    Name = "my-pub-rtb"
  }
}

resource "aws_route_table" "test_pvt_rtb" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "my-pvt-rtb"
  }
}

resource "aws_route_table_association" "my-pub_2a_association" {
  subnet_id = aws_subnet.my-pub_2a.id
  route_table_id = aws_route_table.test_pub_rtb.id
}

resource "aws_route_table_association" "my-pub_2b_association" {
  subnet_id = aws_subnet.my-pub_2b.id
  route_table_id = aws_route_table.test_pub_rtb.id
}

resource "aws_route_table_association" "my-pub_2c_association" {
  subnet_id = aws_subnet.my-pub_2c.id
  route_table_id = aws_route_table.test_pub_rtb.id
}

resource "aws_route_table_association" "my-pub_2d_association" {
  subnet_id = aws_subnet.my-pub_2d.id
  route_table_id = aws_route_table.test_pub_rtb.id
}

resource "aws_route_table_association" "my-pvt_2a_association" {
  subnet_id = aws_subnet.my-pvt_2a.id
  route_table_id = aws_route_table.test_pvt_rtb.id
}

resource "aws_route_table_association" "my-pvt_2b_association" {
  subnet_id = aws_subnet.my-pvt_2b.id
  route_table_id = aws_route_table.test_pvt_rtb.id
}

resource "aws_route_table_association" "my-pvt_2c_association" {
  subnet_id = aws_subnet.my-pvt_2c.id
  route_table_id = aws_route_table.test_pvt_rtb.id
}

resource "aws_route_table_association" "my-pvt_2d_association" {
  subnet_id = aws_subnet.my-pvt_2d.id
  route_table_id = aws_route_table.test_pvt_rtb.id
}

### vpc end ###