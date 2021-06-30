output "nat_eip" {
  value   = aws_eip.nat-eip.*.id
}