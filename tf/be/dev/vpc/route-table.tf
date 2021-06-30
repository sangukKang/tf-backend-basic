/**
  public route table
*/
resource "aws_route_table" "rt-pub" {
  vpc_id      = aws_vpc.vpc.id
//  count       = length(var.rt_pub_list)
  depends_on  = [ aws_internet_gateway.igw ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  route {
    cidr_block = var.rt_pub_list.pcx_cidr_block
    vpc_peering_connection_id = var.rt_pub_list.pcx_id
  }


  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.rt_pub_list.name}"), var.extra_tags)

}

resource "aws_route_table_association" "rt-pub-ac" {
  count           = length(aws_subnet.sn-pub)

  subnet_id       = aws_subnet.sn-pub.*.id[count.index]
  route_table_id  = aws_route_table.rt-pub.id

}


/**
  private route table
*/
resource "aws_route_table" "rt-pri" {
  vpc_id      = aws_vpc.vpc.id
  count       = length(var.rt_pri_list)
  depends_on  = [ aws_nat_gateway.ngw ]

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.*.id[count.index]
  }
  route {
    cidr_block = lookup(var.rt_pri_list[count.index], "pcx_cidr_block")
    vpc_peering_connection_id = lookup(var.rt_pri_list[count.index], "pcx_id")
  }


  tags = merge(
    map("Name", "${var.resrc_prefix_nm}${lookup(var.rt_pri_list[count.index], "az")}-${lookup(var.rt_pri_list[count.index], "name")}"),
    var.extra_tags,
    map("az", lookup(var.rt_pri_list[count.index], "az"))
  )
}

resource "aws_route_table_association" "pri-az-rt" {
  count           = length(aws_subnet.sn-az-pri)

  subnet_id       = aws_subnet.sn-az-pri.*.id[count.index]
  route_table_id = aws_route_table.rt-pri.*.id[0]
}

resource "aws_route_table_association" "pri-cz-rt" {
  count           = length(aws_subnet.sn-cz-pri)

  subnet_id       = aws_subnet.sn-cz-pri.*.id[count.index]
  route_table_id = aws_route_table.rt-pri.*.id[1]
}