output "eip_nat_ids" {
  value = aws_eip.eip_nat.*.id
}