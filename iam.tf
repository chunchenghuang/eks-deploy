resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  })
}

resource "aws_iam_role" "node_role" {
  name = "eks-node-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}



# # IAM Policies (example)
# resource "aws_iam_role_policy" "eks_role_policy" {
#   name   = "eks-cluster-policy"
#   role   = aws_iam_role.eks_role.name
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "ec2:Describe*",
#         "ec2:CreateSecurityGroup",
#         "ec2:DeleteSecurityGroup",
#         "ec2:AuthorizeSecurityGroupIngress",
#         "ec2:AuthorizeSecurityGroupEgress",
#         "ec2:RevokeSecurityGroupIngress",
#         "ec2:RevokeSecurityGroupEgress",
#         "iam:CreateServiceLinkedRole",
#         "iam:GetRole",
#         "iam:PassRole",
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents",
#         "ec2:DescribeSubnets",
#         "ec2:DescribeVpcs" 
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "node_role_policy" {
#   name   = "eks-node-role-policy"
#   role   = aws_iam_role.node_role.name
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "ec2:DescribeInstances",
#         "ec2:DescribeVpcs",
#         "ec2:DescribeSubnets",
#         "ec2:DescribeSecurityGroups",
#         "ec2:DescribeVolumes",
#         "ec2:DescribeTags",
#         "ec2:CreateNetworkInterface",
#         "ec2:DeleteNetworkInterface",
#         "ec2:AttachNetworkInterface",
#         "ec2:DetachNetworkInterface",
#         "ec2:CreateTags",
#         "ec2:DeleteTags",
#         "ec2:ModifyInstanceAttribute",
#         "ec2:DescribeInstanceAttribute",
#         "ec2:DescribeAvailabilityZones",
#         "ec2:DescribeAccountAttributes",
#         "iam:GetRole"
#       ],
#       "Resource": "*"
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "ec2:Describe*" 
#       ],
#       "Resource": ["arn:aws:ec2:*:*:instance/*"]
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "logs:CreateLogGroup",
#         "logs:CreateLogStream",
#         "logs:PutLogEvents"
#       ],
#       "Resource": [
#         "arn:aws:logs:*:*:log-group:/aws/eks/*"
#       ]
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "kms:Decrypt",
#         "kms:DescribeKey"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

resource "aws_iam_role_policy_attachment" "aws_eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "aws_eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_role.name
}

resource "aws_iam_role_policy_attachment" "aws_ec2_container_registry_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_role.name
}
