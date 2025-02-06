resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = data.aws_subnets.selected.ids
    endpoint_public_access = false
    endpoint_private_access = true
  }

  depends_on = [aws_iam_role_policy_attachment.aws_eks_cluster_policy]
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = data.aws_subnets.selected.ids

  scaling_config {  
    desired_size = var.desired_capacity
    max_size     = var.max_size
    min_size     = var.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.aws_eks_worker_node_policy,
    aws_iam_role_policy_attachment.aws_eks_cni_policy,
    aws_iam_role_policy_attachment.aws_ec2_container_registry_readonly,
  ]
}
