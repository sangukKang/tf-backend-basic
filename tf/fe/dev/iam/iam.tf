resource "aws_iam_role" "iam_eks" {
  name = "${var.resrc_prefix_nm}-${var.iam_eks.name}"
  tags = merge(map("Name", "${var.resrc_prefix_nm}-${var.iam_eks.name}"), var.extra_tags)

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [ "eks.amazonaws.com", "ec2.amazonaws.com" ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "iam_eks_atm" {
  count       = length(var.iam_eks.policy_list)
  policy_arn  = var.iam_eks.policy_list[count.index].arn
  role        = aws_iam_role.iam_eks.name
}