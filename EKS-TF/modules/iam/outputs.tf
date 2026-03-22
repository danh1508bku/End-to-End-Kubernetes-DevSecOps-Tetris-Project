output "eks_cluster_role_arn" {
  value = aws_iam_role.EKSClusterRole.arn
}

output "node_group_role_arn" {
  value = aws_iam_role.NodeGroupRole.arn
}