data "aws_availability_zones" "available" {}

data "aws_vpc" "selected" {
  id = var.create_vpc ? aws_vpc.vpc[0].id : var.vpc_id
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }
}