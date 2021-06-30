output "iam_eks_arn" {
  value = aws_iam_role.iam_eks.arn
}

output "iam_eks_atm" {
  value = aws_iam_role_policy_attachment.iam_eks_atm.*
}