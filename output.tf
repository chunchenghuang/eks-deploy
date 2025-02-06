output "subnet_ids_list" {
    value =  var.create_vpc ? aws_subnet.subnets[*].id : null
}
