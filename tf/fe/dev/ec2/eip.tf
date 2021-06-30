resource "aws_eip" "eip_nat" {
  count = length(var.eip_nat_list)
  vpc   = var.eip_nat_list[count.index].vpc

  tags  = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.eip_nat_list[count.index], "az")}-${lookup(var.eip_nat_list[count.index], "name")}"), var.extra_tags)
}
resource "aws_eip" "eip_bastion" {
  vpc   = var.eip_bastion.vpc

  tags  = merge(map("Name", "${var.resrc_prefix_nm}-${var.eip_bastion.name}"), var.extra_tags)
}

resource "aws_eip_association" "eip_bastion_as" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.eip_bastion.id
}