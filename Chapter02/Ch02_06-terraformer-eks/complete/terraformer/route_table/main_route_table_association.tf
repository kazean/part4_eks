resource "aws_main_route_table_association" "tfer--vpc-0f55c9e30ef5aef32" {
  route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-01e5f139c1d7c0152_id}"
  vpc_id         = "vpc-0f55c9e30ef5aef32"
}
