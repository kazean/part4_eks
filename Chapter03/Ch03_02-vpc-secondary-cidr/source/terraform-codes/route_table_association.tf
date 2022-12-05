#tfer--subnet-0d390e6402fc78468
resource "aws_route_table_association" "route-association-pub-sub1" {
  # route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-091680a4075bd0937_id}"
  route_table_id = aws_route_table.public-subnet1-routing.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

#tfer--subnet-0e81f58c442fcb870
resource "aws_route_table_association" "route-association-pub-sub3" {
  # route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-0bee09895bb1b7848_id}"
  route_table_id = aws_route_table.public-subnet3-routing.id
  subnet_id      = aws_subnet.public-subnet-3.id
}

###SECONDARY rta
#test-rta-eks-pods-a
resource "aws_route_table_association" "test-rta-eks-pods-a" {
  route_table_id = aws_route_table.test-rt-eks-pods-a.id
  subnet_id      = aws_subnet.public-subnet-eks-pods-a.id
}

#test-rta-eks-pods-c
resource "aws_route_table_association" "test-rta-eks-pods-c" {
  route_table_id = aws_route_table.test-rt-eks-pods-c.id
  subnet_id      = aws_subnet.public-subnet-eks-pods-c.id
}