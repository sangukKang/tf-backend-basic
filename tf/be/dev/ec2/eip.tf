# Create EIP for Nat Gateway
resource "aws_eip" "nat-eip" {
  count = length(var.nat_eip_list)
  vpc   = true

  tags = merge(map("Name", "${var.resrc_prefix_nm}${lookup(var.nat_eip_list[count.index], "az")}-${lookup(var.nat_eip_list[count.index], "name")}"), var.extra_tags)
}

resource "aws_eip" "bastion" {
  vpc         = true
  depends_on  = [ aws_instance.bastion ]
  instance    = aws_instance.bastion.id

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.bastion_eip.name}"), var.extra_tags)
}