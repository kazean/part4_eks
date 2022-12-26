resource "aws_route_table" "public-subnet1-routing" {
  
  depends_on = [
    aws_vpc.default-vpc,
    aws_internet_gateway.default-internet-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-internet-gateway.id
  }

  tags = {
    Name = "public-subent1-routing"
  }

  tags_all = {
    Name = "public-subent1-routing"
  }

  vpc_id = aws_vpc.default-vpc.id
}


resource "aws_route_table" "public-subnet3-routing" {


  depends_on = [
    aws_vpc.default-vpc,
    aws_internet_gateway.default-internet-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-internet-gateway.id
  }

  tags = {
    Name = "public-subnet3-routing"
  }

  tags_all = {
    Name = "public-subnet3-routing"
  }

  vpc_id = aws_vpc.default-vpc.id
}