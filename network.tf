resource "aws_vpc" "ec2vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_tags
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ec2vpc.id
  tags = {
    Name = "Private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ec2vpc.id
  tags = {
    Name = "Public"
  }
}

resource "aws_internet_gateway" "vpcigw" {
  vpc_id = aws_vpc.ec2vpc.id
  tags = {
    Name = "VPC-Internet_gateway"
  }
}

resource "aws_route" "igwaccess" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = local.anywhere
  gateway_id             = aws_internet_gateway.vpcigw.id
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.ec2vpc.id
  count                   = length(var.public_subnet)
  availability_zone       = var.public_subnet[count.index].availability_zone
  cidr_block              = var.public_subnet[count.index].cidr_block
  map_public_ip_on_launch = var.public_subnet[count.index].map_public_ip_on_launch
  tags = {
    Name = format("%s-%s", local.ec_name, var.public_subnet[count.index].name)
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.ec2vpc.id
  count                   = length(var.private_subnet)
  availability_zone       = var.private_subnet[count.index].availability_zone
  cidr_block              = var.private_subnet[count.index].cidr_block
  map_public_ip_on_launch = var.private_subnet[count.index].map_public_ip_on_launch
  tags = {
    Name = format("%s-%s", local.ec_name, var.private_subnet[count.index].name)
  }
}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet)
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "web" {
  name   = var.web_security_group.name
  vpc_id = aws_vpc.ec2vpc.id
  tags = {
    Name = var.web_security_group.name
  }
}
# ingress traffic
resource "aws_vpc_security_group_ingress_rule" "web" {
  count             = length(var.web_security_group.ingress_rules)
  cidr_ipv4         = var.web_security_group.ingress_rules[count.index].cidr_ipv4
  from_port         = var.web_security_group.ingress_rules[count.index].from_port
  ip_protocol       = var.web_security_group.ingress_rules[count.index].ip_protocol
  to_port           = var.web_security_group.ingress_rules[count.index].to_port
  security_group_id = aws_security_group.web.id
}

# egress rules
resource "aws_vpc_security_group_egress_rule" "web" {
  cidr_ipv4         = local.anywhere
  from_port         = -1
  ip_protocol       = "-1"
  to_port           = -1
  security_group_id = aws_security_group.web.id
}

