resource "aws_vpc" "vpc" {
  count = var.create_vpc ? 1 : 0
  cidr_block = var.vpc_cidr

  tags = {
    Tier = "EKS"
  }
}


resource "aws_subnet" "subnets" {
  count = var.create_vpc ? 2 : 0
  vpc_id     = aws_vpc.vpc[0].id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Tier = "EKS"
  }
}

# resource "aws_security_group" "eks_cluster_sg" {
#   name        = "eks-cluster-sg"
#   description = "Security Group for EKS Cluster"
#   vpc_id      = data.aws_vpc.selected.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     from_port   = -1 
#     to_port     = -1 
#     protocol    = "icmp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
