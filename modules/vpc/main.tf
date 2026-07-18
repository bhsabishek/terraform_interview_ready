resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  for_each = {
    for index, cidr in var.public_subnets :
    index => cidr
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = var.azs[each.key]

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-public-${each.key + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each = {
    for index, cidr in var.private_subnets :
    index => cidr
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = var.azs[each.key]

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-private-${each.key + 1}"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-IGW"
  }
}

resource "aws_route" "my_r" {
  route_table_id         = aws_route_table.my_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_igw.id
}

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.this.id

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-RT"
  }
}

resource "aws_route_table_association" "my_rt_public_a" {
  for_each = aws_subnet.public_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_eip" "my_eip" {
  domain = "vpc"

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-EIP"
  }
}

resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet["0"].id

  depends_on = [
    aws_internet_gateway.my_igw
  ]

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-NAT-GW"
  }
}

resource "aws_route" "my_nat_r" {
  route_table_id         = aws_route_table.my_nat_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_nat_gw.id
}

resource "aws_route_table" "my_nat_rt" {
  vpc_id = aws_vpc.this.id

  tags = {
    Project     = var.proj_name
    Environment = var.env
    ManagedBy   = "terraform"
    Name        = "${var.proj_name}-${var.env}-NAT-RT"
  }
}

resource "aws_route_table_association" "my_rt_private_a" {
  for_each = aws_subnet.private_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.my_nat_rt.id
}