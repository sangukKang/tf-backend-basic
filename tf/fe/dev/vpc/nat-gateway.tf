resource "aws_nat_gateway" "nat" {
  count         = length(var.nat_list)
  allocation_id = var.eip_nat_ids[count.index]
  subnet_id     = aws_subnet.sn_pub.*.id[count.index]

  tags = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.nat_list[count.index], "az")}-${lookup(var.nat_list[count.index], "name")}"), var.extra_tags)
}