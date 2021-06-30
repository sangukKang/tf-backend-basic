output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "sn_pub_a_id" {
  value = aws_subnet.sn_pub.*.id[0]
}

output "sn_pub_c_id" {
  value = aws_subnet.sn_pub.*.id[1]
}

output "sn_waf_a_id" {
  value = aws_subnet.sn_pri_a.*.id[0]
}

output "sn_waf_c_id" {
  value = aws_subnet.sn_pri_c.*.id[0]
}

output "sn_biz_a_id" {
  value = aws_subnet.sn_pri_a.*.id[1]
}

output "sn_biz_c_id" {
  value = aws_subnet.sn_pri_c.*.id[1]
}

output "sn_db_a_id" {
  value = aws_subnet.sn_pri_a.*.id[2]
}

output "sn_db_c_id" {
  value = aws_subnet.sn_pri_c.*.id[2]
}

output "sn_ecr_a_id" {
  value = aws_subnet.sn_pri_a.*.id[3]
}

output "sn_ecr_c_id" {
  value = aws_subnet.sn_pri_c.*.id[3]
}

output "sg_bastion_id" {
  value = aws_security_group.sg_bastion.id
}