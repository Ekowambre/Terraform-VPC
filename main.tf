# Tenacity IT Group VPC
resource "aws_vpc" "Project-VPC" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.tenancy
  enable_dns_hostnames = var.dns-toggle

  tags = {
    Name = var.vpc_tag
  }
}


# Public subnet-1
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = var.Prod_pub_sub_1_cidr
  availability_zone = var.AZ-1

  tags = {
    Name = var.Pub-1-tag
  }
}

# public subnet-2
resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = var.Prod_pub_sub_2_cidr
  availability_zone = var.AZ-2

  tags = {
    Name = var.Pub-2-tag
  }
}

# Private subnet 1
resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = var.Prod_priv_sub_1_cidr
  availability_zone = var.AZ-3

  tags = {
    Name = var.Priv-1-tag
  }
}
# Private subnet 2
resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id            = aws_vpc.Project-VPC.id
  cidr_block        = var.Prod_priv_sub_2_cidr
  availability_zone = var.AZ-4

  tags = {
    Name = var.Priv-2-tag
  }
}

# Project route table-public
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.Project-VPC.id
  tags = {
    Name = var.Public-route-table-tag
  }
}


# Project route table-Private
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.Project-VPC.id
  tags = {
    Name = var.Private-route-table-tag
  }
}
# Project public sub association
resource "aws_route_table_association" "Project-public-route-association-1" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}


# Project public sub association
resource "aws_route_table_association" "Project-public-route-association-2" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}



# Project private sub association
resource "aws_route_table_association" "Project-private-route-association-1" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}


# Project private sub association
resource "aws_route_table_association" "Project-private-route-association-2" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}

# Project internet gateway
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.Project-VPC.id

  tags = {
    Name = var.igw
  }
}
# Project IGW route
resource "aws_route" "Prod-igw-association" {
  route_table_id         = aws_route_table.Prod-pub-route-table.id
  gateway_id             = aws_internet_gateway.Prod-igw.id
  destination_cidr_block = var.igw-cidr
}


# Allocation of Elastic IP
resource "aws_eip" "Prod-EIP" {

}



# Project NG
resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.Prod-EIP.id
  subnet_id     = aws_subnet.Prod-pub-sub1.id


  tags = {
    Name = var.Nat-tag
  }

}

# Associating Nat gateway with private route table
resource "aws_route" "Prod-Nat-association" {
  route_table_id         = aws_route_table.Prod-priv-route-table.id
  gateway_id             = aws_nat_gateway.Prod-Nat-gateway.id
  destination_cidr_block = var.Nat-cidr
}