output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_pub_ids" {
  value = aws_subnet.sn-pub.*.id
}

output "subnet_pri_az_ids" {
  value = aws_subnet.sn-az-pri.*.id
}

output "subnet_pri_cz_ids" {
  value = aws_subnet.sn-cz-pri.*.id
}

output "sg_bastion" {
  value = aws_security_group.sg-bastion.id
}

output "sg_cicd" {
  value = aws_security_group.sg-cicd.id
}