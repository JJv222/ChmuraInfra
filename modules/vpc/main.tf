# Pobierz dostępne AZ w regionie
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = { Name = "${var.project_name}-vpc" }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project_name}-igw" }
}

# Public Subnets
resource "aws_subnet" "public" {
  count                = length(var.public_subnets)
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.public_subnets[count.index]
  availability_zone    = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "${var.project_name}-public-subnet-${count.index + 1}" }
}

# Private Subnets
resource "aws_subnet" "private" {
  count                = length(var.private_subnets)
  vpc_id               = aws_vpc.this.id
  cidr_block           = var.private_subnets[count.index]
  availability_zone    = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "${var.project_name}-private-subnet-${count.index + 1}" }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project_name}-public-rt" }
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.project_name}-private-rt" }
}

# Public Route (Internet Gateway)
resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.this.id
}

# Associate Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Associate Private Route Table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}