# Tenacity IT Group VPC
resource "aws_vpc" "Project-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Project-VPC"
  }
}


# Public subnet-1
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id = aws_vpc.Project-VPC.id
  cidr_block = "10.0.1.0/24"

tags = {
    Name = "Prod-pub-sub1"
  }
}

# public subnet-2
resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id = aws_vpc.Project-VPC.id
  cidr_block = "10.0.2.0/24"
  
tags = {
    Name = "Prod-pub-sub2"
  }
}

# Private subnet 1
resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id = aws_vpc.Project-VPC.id
  cidr_block = "10.0.3.0/24"
  
tags = {
    Name = "Prod-priv-sub1"
  }
}
# Private subnet 2
resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id = aws_vpc.Project-VPC.id
  cidr_block = "10.0.4.0/24"
  
tags = {
    Name = "Prod-priv-sub2"
  }
}

# Project route table-public
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.Project-VPC.id
tags     = {
  Name   ="Prod-pub-route-table"
  }
}


# Project route table-Private
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.Project-VPC.id
tags     = {
  Name   ="Prod-priv-route-table"
  }
}
# Projet public sub association
resource "aws_route_table_association" "Project-public-route-association-1" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}


# Projet public sub association
resource "aws_route_table_association" "Project-public-route-association-2" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}



# Projet private sub association
resource "aws_route_table_association" "Project-private-route-association-1" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}


# Projet private sub association
resource "aws_route_table_association" "Project-private-route-association-2" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# Project internet gateway
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Project-VPC.id

  tags = {
    Name = "Prod-igw"
  }
}
# Project IGW route
resource "aws_route" "Prod-igw-association" {
  route_table_id            = aws_route_table.Prod-pub-route-table.id
  gateway_id                = aws_internet_gateway.Prod-igw.id
  destination_cidr_block    = "0.0.0.0/0"
}


# Allocation of Elastic IP
resource "aws_eip" "Prod-EIP" {

}



# Project NG
resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.Prod-EIP.id
  subnet_id     = aws_subnet.Prod-pub-sub1.id
  

  tags = {
    Name = "Prod-Nat-gateway"
  }

}

# Associating Nat gateway with private route table
resource "aws_route" "Prod-Nat-association" {
  route_table_id            = aws_route_table.Prod-priv-route-table.id
  gateway_id                = aws_nat_gateway.Prod-Nat-gateway.id
  destination_cidr_block    = "0.0.0.0/0"
}