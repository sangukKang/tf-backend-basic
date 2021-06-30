# Create Nat Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = var.nat_eip[count.index]
  count       = length(var.nat_list)
  subnet_id     = aws_subnet.sn-pub.*.id[count.index]

//  depends_on = [aws_eip.eip]

  tags = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.nat_list[count.index], "az")}-${lookup(var.nat_list[count.index], "name")}"), var.extra_tags)
}