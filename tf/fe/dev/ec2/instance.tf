resource "aws_instance" "bastion" {
  ami                         = var.ec2_bastion.ami
  instance_type               = var.ec2_bastion.instance_type
  key_name                    = var.ec2_bastion.key_name
  subnet_id                   = var.sn_pub_a_id
  vpc_security_group_ids      = [ var.sg_bastion_id ]
  associate_public_ip_address = var.ec2_bastion.associate_public_ip_address

  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.ec2_bastion.name}"), var.extra_tags)
}