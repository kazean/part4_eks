# default route table
# resource "aws_route_table" "tfer--rtb-01e5f139c1d7c0152" {
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = "igw-07147ad5c2b7e2d18"
#   }

#   tags = {
#     Name = "default"
#   }

#   tags_all = {
#     Name = "default"
#   }

#   vpc_id = "vpc-0f55c9e30ef5aef32"
# }

#tfer--rtb-091680a4075bd0937
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

#tfer--rtb-0bee09895bb1b7848
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


###SECONDARY ROUTE

#test-rt-eks-pods-a
resource "aws_route_table" "test-rt-eks-pods-a" {
  
  depends_on = [
    aws_vpc.default-vpc,
    aws_internet_gateway.default-internet-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-internet-gateway.id
  }

  tags = {
    Name = "test-rt-eks-pods-a-routing"
  }

  tags_all = {
    Name = "test-rt-eks-pods-a-routing"
  }

  vpc_id = aws_vpc.default-vpc.id
}

#test-rt-eks-pods-c
resource "aws_route_table" "test-rt-eks-pods-c" {
  
  depends_on = [
    aws_vpc.default-vpc,
    aws_internet_gateway.default-internet-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default-internet-gateway.id
  }

  tags = {
    Name = "test-rt-eks-pods-c-routing"
  }

  tags_all = {
    Name = "test-rt-eks-pods-c-routing"
  }

  vpc_id = aws_vpc.default-vpc.id
}