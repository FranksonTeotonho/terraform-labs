#---------------------------------
# Data Source - AZs
#---------------------------------
data "aws_availability_zones" "available_azs" {
  state = "available"
}

#---------------------------------
# VPC
#---------------------------------
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "terraform-${var.env}-vpc"
  }
}

#---------------------------------
# Public Subnets
#---------------------------------
resource "aws_subnet" "public_subnets" {
  count                   = var.number_of_public_subnets
  cidr_block              = var.public_subnets_cidr[count.index]
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available_azs.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-${var.env}-public-subnet-${count.index}"
  }
}

#---------------------------------
# Private Subnets
#---------------------------------
resource "aws_subnet" "private_subnets" {
  count             = var.number_of_private_subnets
  cidr_block        = var.privates_subnets_cidr[count.index]
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available_azs.names[count.index]

  tags = {
    Name = "terraform-${var.env}-private-subnet-${count.index}"
  }
}

#---------------------------------
# Internet Gateway
#---------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terraform-${var.env}-igw"
  }
}

#---------------------------------
# Public route table
#---------------------------------
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "terraform-${var.env}-public-rt"
  }
}

resource "aws_route_table_association" "public_association" {
  count = var.number_of_public_subnets
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

#---------------------------------
# Private route table
#---------------------------------
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terraform-${var.env}-private-rt"
  }
}

resource "aws_route_table_association" "private_association" {
  count = var.number_of_private_subnets
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}