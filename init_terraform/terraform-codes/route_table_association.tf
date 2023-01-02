resource "aws_route_table_association" "route-association-pub-sub1" {
  route_table_id = aws_route_table.public-subnet1-routing.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "route-association-pub-sub3" {
  route_table_id = aws_route_table.public-subnet3-routing.id
  subnet_id      = aws_subnet.public-subnet-3.id
}
