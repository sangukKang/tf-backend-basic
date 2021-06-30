resource "aws_route_table" "rt_pub" {
  vpc_id  = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  /*
  route {
    cidr_block = var.rt_pub_list.pcx_cidr_block
    gateway_id = var.rt_pub_list.pcx_id
  }*/

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.rt_pub_list.name}"), var.extra_tags)
}

resource "aws_route_table" "rt_pri" {
  count   = length(var.rt_pri_list)
  vpc_id  = aws_vpc.vpc.id

  route {
    cidr_block = var.cidr
    gateway_id = aws_nat_gateway.nat.*.id[count.index]
  }

  /*
  route {
    cidr_block = lookup(var.rt_pri_list[count.index], "pcx_cidr_block")
    gateway_id = lookup(var.rt_pri_list[count.index], "pcx_id")
  }*/

  tags = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.rt_pri_list[count.index], "az")}-${var.rt_pri_list[count.index].name}"), var.extra_tags)
}

resource "aws_route_table_association" "rt_pub_ac" {
  count           = length(aws_subnet.sn_pub)

  subnet_id       = aws_subnet.sn_pub.*.id[count.index]
  route_table_id  = aws_route_table.rt_pub.id
}

resource "aws_route_table_association" "rt_pri_a_ac" {
  count           = length(aws_subnet.sn_pri_a)

  subnet_id       = aws_subnet.sn_pri_a.*.id[count.index]
  route_table_id  = aws_route_table.rt_pri.*.id[0]
}

resource "aws_route_table_association" "rt_pri_c_ac" {
  count           = length(aws_subnet.sn_pri_c)

  subnet_id       = aws_subnet.sn_pri_c.*.id[count.index]
  route_table_id  = aws_route_table.rt_pri.*.id[1]
}