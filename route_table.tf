#########################################################
###############    Public Routes   ######################
#########################################################

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "Route public subnet traffic to internet gateway"
  }
}

resource "aws_route_table_association" "main_public" {
  subnet_id      = aws_subnet.main-public.id
  route_table_id = aws_route_table.public_route_table.id
}

#########################################################
###############    Private Routes  ######################
#########################################################

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Private route table does not need any explicit routes."
  }
}

resource "aws_route_table_association" "main_private" {
  subnet_id      = aws_subnet.main-private.id
  route_table_id = aws_route_table.private_route_table.id
}