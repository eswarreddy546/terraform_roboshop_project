resource "aws_vpc" "main" {
  cidr_block           = var.mycidr
  enable_dns_hostnames = true

  tags = merge(
    var.project_tag,
    {
      Environment = var.environment
    }
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_subnet" "main" {
    count      = length(var.publicsubnet)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.publicsubnet[count.index]
  availability_zone = local.az[count.index]
  map_public_ip_on_launch = true


  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_subnet" "mainprivate" {
  count      = length(var.privatesubnet)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.privatesubnet[count.index]
  availability_zone = local.az[count.index]
  map_public_ip_on_launch = false


  tags = {
    Name = "private-subnet-${count.index}"
  }
}


resource "aws_subnet" "mainprivatedatabase" {
  count      = length(var.privatedatabasesubnet)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.privatedatabasesubnet[count.index]
  availability_zone = local.az[count.index]
  map_public_ip_on_launch = false


  tags = {
    Name = "privatedatabase-subnet-${count.index}"
  }
}


resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "public_route"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = length(var.publicsubnet)
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.publicrt.id
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "public_route"
  }
}
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.privatesubnet)
  subnet_id      = aws_subnet.mainprivate[count.index].id
  route_table_id = aws_route_table.privatert.id
}

resource "aws_route_table_association" "privatedb_assoc" {
  count          = length(var.privatedatabasesubnet)
  subnet_id      = aws_subnet.mainprivatedatabase[count.index].id
  route_table_id = aws_route_table.privatedatabasert.id
}

resource "aws_route_table" "privatedatabasert" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "public_route"
  }
}




resource "aws_route" "route" {
  route_table_id            = aws_route_table.publicrt.id
  destination_cidr_block    = var.route
  gateway_id = aws_internet_gateway.gw.id
}

resource "aws_eip" "eipexample" {
  domain = "vpc" # Specifies the EIP is for use in a VPC

  tags = {
    Name = "example-eip"
  }
}

resource "aws_nat_gateway" "natexample" {
  allocation_id = aws_eip.eipexample.id
  subnet_id = aws_subnet.main[0].id
  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_route" "privateroute" {
  route_table_id            = aws_route_table.privatert.id
  destination_cidr_block    = var.route
  nat_gateway_id         = aws_nat_gateway.natexample.id
}

resource "aws_route" "privatedatabasert" {
  route_table_id            = aws_route_table.privatedatabasert.id
  destination_cidr_block    = var.route
  nat_gateway_id         = aws_nat_gateway.natexample.id
}