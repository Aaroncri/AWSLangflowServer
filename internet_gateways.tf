resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main.id # This attaches my IGW to the main VPC created in 'vpc.tf'

  tags = {
    Name = "Netsec-Main-IGW" # Name that will show up in AWS console
  }
}