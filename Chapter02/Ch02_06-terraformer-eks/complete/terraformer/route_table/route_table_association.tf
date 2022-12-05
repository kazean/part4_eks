resource "aws_route_table_association" "tfer--subnet-0d390e6402fc78468" {
  route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-091680a4075bd0937_id}"
  subnet_id      = "subnet-0d390e6402fc78468"
}

resource "aws_route_table_association" "tfer--subnet-0e81f58c442fcb870" {
  route_table_id = "${data.terraform_remote_state.local.outputs.aws_route_table_tfer--rtb-0bee09895bb1b7848_id}"
  subnet_id      = "subnet-0e81f58c442fcb870"
}
