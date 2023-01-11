resource "aws_vpc" "this" {

  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true


  tags = {
    "Name" = "${var.application_name}_vpc-01"
  }

}

resource "aws_subnet" "public-sub-A" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.0.0/25"
  availability_zone = "us-east-1a"


  tags = {
    "Name" = "${var.application_name}_public-sub-A"
  }
}

resource "aws_subnet" "public-sub-B" {
  cidr_block        = "192.168.0.128/25"
  vpc_id            = aws_vpc.this.id
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "${var.application_name}_public-sub-B"
  }
}



resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "${var.application_name}_internet-gw"
  }


}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id


  tags = {
    "Name" = "${var.application_name}_rttb-public"
  }

}

resource "aws_route_table_association" "public-a" {

  subnet_id      = aws_subnet.public-sub-A.id
  route_table_id = aws_route_table.this.id

}


resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-sub-B.id
  route_table_id = aws_route_table.this.id
}

resource "aws_route" "this" {

  route_table_id         = aws_route_table.this.id
  destination_cidr_block = var.internet_route
  gateway_id             = aws_internet_gateway.this.id

}

