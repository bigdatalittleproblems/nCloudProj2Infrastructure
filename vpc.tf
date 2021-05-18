resource "aws_vpc" "main" {
  cidr_block = var.cidr

  tags = {
    Name        = var.name
    Environment = terraform.workspace
    terraform   = "true"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = local.count
  cidr_block              = cidrsubnet(var.cidr, 4, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.name} Public ${terraform.workspace}"
    Environment = terraform.workspace
    terraform   = "true"
    "kubernetes.io/cluster/my-cluster" = "shared"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = var.name
    Environment = terraform.workspace
    terraform   = "true"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  count                   = local.count
  cidr_block              = cidrsubnet(var.cidr, 4, count.index + local.count)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.name} Private ${terraform.workspace}"
    Environment = terraform.workspace
    terraform   = "true"
  }
}

resource "aws_eip" "nat" {
  vpc   = true
  count = 1
}

resource "aws_nat_gateway" "main" {
  allocation_id = element(aws_eip.nat.*.id, count.index)
  count         = 1
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = {
    terraform = "true"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  count  = local.count

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.main.*.id, count.index)
  }

  tags = {
    Name        = "${var.name} Private ${terraform.workspace}"
    Environment = terraform.workspace
    terraform   = "true"
  }
}

resource "aws_route_table_association" "private" {
  count          = local.count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name} Default"
    terraform   = "true"
    Environment = terraform.workspace
  }
}

# resource "aws_elasticache_cluster" "example" {
#   cluster_id           = "cluster-example"
#   engine               = "redis"
#   node_type            = "cache.t3.micro"
#   num_cache_nodes      = 1
#   parameter_group_name = "default.redis3.2"
#   engine_version       = "3.2.10"
#   port                 = 6379
# }


