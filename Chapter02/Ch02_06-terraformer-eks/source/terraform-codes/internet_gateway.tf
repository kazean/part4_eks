resource "aws_internet_gateway" "default-internet-gateway" {

  depends_on = [
    aws_vpc.default-vpc
  ]

  vpc_id = aws_vpc.default-vpc.id
}
