resource "aws_vpc" "main" {

 cidr_block = var.main_vpc_cidr_block #This is a variable declared in 'vars.tf'

 
 tags = {

   Name = "Netsec-Main-VPC" # Name that will show up in AWS console

 }

}

resource "aws_subnet" "main-public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "us-east-1a" # or any valid AZ
  map_public_ip_on_launch = true

  tags = {
    Name = "main-public-subnet"
  }
}