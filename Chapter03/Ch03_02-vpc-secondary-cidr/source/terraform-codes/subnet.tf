#"tfer--subnet-0d390e6402fc78468"
resource "aws_subnet" "public-subnet-3" {

  depends_on = [
    aws_vpc.default-vpc
  ]

  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "172.31.32.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "public-subnet-3"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  tags_all = {
    Name                                     = "public-subnet-3"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  vpc_id = aws_vpc.default-vpc.id
  availability_zone = "ap-northeast-2c"
}
#"tfer--subnet-0e81f58c442fcb870"
resource "aws_subnet" "public-subnet-1" {
  
  depends_on = [
    aws_vpc.default-vpc
  ]

  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "172.31.0.0/20"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "public-subnet-1"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  tags_all = {
    Name                                     = "public-subnet-1"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  vpc_id = aws_vpc.default-vpc.id
  availability_zone = "ap-northeast-2a"
}

### SECONDARY CIDER

#public-subnet-eks-pods-a
resource "aws_subnet" "public-subnet-eks-pods-a" {
  
  depends_on = [
    aws_vpc.default-vpc
  ]

  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "100.64.0.0/19"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "public-subnet-eks-pods-a"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  tags_all = {
    Name                                     = "public-subnet-eks-pods-a"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  vpc_id = aws_vpc.default-vpc.id
  availability_zone = "ap-northeast-2a"
}

#public-subnet-eks-pods-c
resource "aws_subnet" "public-subnet-eks-pods-c" {
  
  depends_on = [
    aws_vpc.default-vpc
  ]

  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "100.64.32.0/19"
  enable_dns64                                   = "false"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  # map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "true"
  private_dns_hostname_type_on_launch            = "ip-name"

  tags = {
    Name                                     = "public-subnet-eks-pods-c"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  tags_all = {
    Name                                     = "public-subnet-eks-pods-c"
    "kubernetes.io/cluster/test-eks-cluster" = "shared"
  }

  vpc_id = aws_vpc.default-vpc.id
  availability_zone = "ap-northeast-2c"
}
