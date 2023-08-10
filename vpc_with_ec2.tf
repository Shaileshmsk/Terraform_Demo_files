terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}
resource "aws_instance" "DemoInstance" {
  ami = var.os-name
  instance_type = var.instance-type
  key_name = var.key
  availability_zone = var.region
  subnet_id = aws_subnet.DemoSubnet.id
  vpc_security_group_ids = [aws_security_group.DemoVPC_SG.id]
}

resource "aws_vpc" "demovpc" {
  cidr_block = var.vpc-cidr
}
resource "aws_subnet" "DemoSubnet" {
  vpc_id     = aws_vpc.demovpc.id
  cidr_block = var.subnet-cidr
  availability_zone = var.subnet-az
  map_public_ip_on_launch = "true"
  tags = {
    Name = "DemoSubnet"
  }
}

resource "aws_internet_gateway" "DemoGateway" {
  vpc_id = aws_vpc.demovpc.id

  tags = {
    Name = "DemoGateway"
  }
}
resource "aws_route_table" "DemoRT" {
  vpc_id = aws_vpc.demovpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.DemoGateway.id
  }

  tags = {
    Name = "DemoRT"
  }
}
resource "aws_route_table_association" "DemoRT_association" {
  subnet_id      =  aws_subnet.DemoSubnet.id
  route_table_id = aws_route_table.DemoRT.id
}

resource "aws_security_group" "DemoVPC_SG" {
  name        = "DemoVPC_SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demovpc.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
