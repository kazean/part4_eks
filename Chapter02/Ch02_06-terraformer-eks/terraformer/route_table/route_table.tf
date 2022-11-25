resource "aws_route_table" "tfer--rtb-01e5f139c1d7c0152" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-07147ad5c2b7e2d18"
  }

  tags = {
    Name = "default"
  }

  tags_all = {
    Name = "default"
  }

  vpc_id = "vpc-0f55c9e30ef5aef32"
}

resource "aws_route_table" "tfer--rtb-091680a4075bd0937" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-07147ad5c2b7e2d18"
  }

  tags = {
    Name = "public-subnet3-routing"
  }

  tags_all = {
    Name = "public-subnet3-routing"
  }

  vpc_id = "vpc-0f55c9e30ef5aef32"
}

resource "aws_route_table" "tfer--rtb-0bee09895bb1b7848" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-07147ad5c2b7e2d18"
  }

  tags = {
    Name = "public-subent1-routing"
  }

  tags_all = {
    Name = "public-subent1-routing"
  }

  vpc_id = "vpc-0f55c9e30ef5aef32"
}
