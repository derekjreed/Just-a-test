resource "aws_vpc" "local" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "local1" {
  vpc_id     = aws_vpc.local1.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Local1"
  }
}

resource "aws_subnet" "local2" {
  vpc_id     = aws_vpc.local2.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Local2"
  }
}

resource"aws_vpc" "remote" {
  cidr_block = "11.0.0.0/16"
}

resource "aws_subnet" "remote1" {
  vpc_id     = aws_vpc.remote1.id
  cidr_block = "11.0.1.0/24"

  tags = {
    Name = "Remote1"
  }
}

resource "aws_subnet" "remote2" {
  vpc_id     = aws_vpc.remote2.id
  cidr_block = "11.0.2.0/24"

  tags = {
    Name = "Remote2"
  }
}

resource "aws_ec2_transit_gateway" "local-tgw" {
  description = "local_tgw"
  tags = {
    "Name" = "local-tgw"
  }
}

resource "aws_ec2_transit_gateway" "remote-tgw" {
  description = "remote_tgw"
  tags = {
    "Name" = "remote-tgw"
  }
}

resource "aws_route_table" "localr" {
  vpc_id = aws_vpc.local1.id

  tags = {
    Name = "local_main"
  }
}

resource "aws_route_table" "remoter" {
  vpc_id = aws_vpc.remote1.id

  tags = {
    Name = "remote_main"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "local1" {
  subnet_ids         = [aws_subnet.local1.id]
  transit_gateway_id = aws_ec2_transit_gateway.local1.id
  vpc_id             = aws_vpc.local.id

  tags = {
    Name = "local_tgw_attach"
  }

}

resource "aws_ec2_transit_gateway_vpc_attachment" "remote1" {
  subnet_ids         = [aws_subnet.remote1.id]
  transit_gateway_id = aws_ec2_transit_gateway.remote1.id
  vpc_id             = aws_vpc.remote.id

  tags = {
    Name = "local_tgw_attach"
  }

}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "test1" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.test1.id
  vpc_id = aws_vpc.local.id
  subnet_ids = aws_subnet.local1[*].vpc_id

  tags = {
    Name = "local_tgw_attach"
  }
}
