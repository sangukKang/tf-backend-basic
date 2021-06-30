resource "aws_subnet" "sn_pub" {
  count               = length(var.sn_pub_list)
  vpc_id              = aws_vpc.vpc.id
  cidr_block          = lookup(var.sn_pub_list[count.index], "cidr_block")
  availability_zone   = lookup(var.sn_pub_list[count.index], "availability_zone")

  tags = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.sn_pub_list[count.index], "az")}-${lookup(var.sn_pub_list[count.index], "name")}"), var.extra_tags)
}

resource "aws_subnet" "sn_pri_a" {
  count               = length(var.sn_pri_a_list)
  vpc_id              = aws_vpc.vpc.id
  cidr_block          = lookup(var.sn_pri_a_list[count.index], "cidr_block")
  availability_zone   = lookup(var.sn_pri_a_list[count.index], "availability_zone")

  tags = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.sn_pri_a_list[count.index], "az")}-${lookup(var.sn_pri_a_list[count.index], "name")}"), var.extra_tags)
}

resource "aws_subnet" "sn_pri_c" {
  count               = length(var.sn_pri_c_list)
  vpc_id              = aws_vpc.vpc.id
  cidr_block          = lookup(var.sn_pri_c_list[count.index], "cidr_block")
  availability_zone   = lookup(var.sn_pri_c_list[count.index], "availability_zone")

  tags = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.sn_pri_c_list[count.index], "az")}-${lookup(var.sn_pri_c_list[count.index], "name")}"), var.extra_tags)
}