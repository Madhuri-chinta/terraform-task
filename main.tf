resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "subnet" {
  cidr_block = "192.168.0.0/24"
  vpc_id     = aws_vpc.vpc.id

  tags = {
    Name = "mysubnet"
  }
  depends_on = [
    aws_vpc.vpc
  ]

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "myigw"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "myroute"
  }
}

resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.routetable.id
}

resource "aws_security_group" "securitygroup" {
  name   = "devops"
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "mysg"
  }
}