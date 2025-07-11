output "vpc_id" {
    value = aws_vpc.master_vpc.id
}

output "public_subnet_ids" {
    value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
    value = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "nat_gateway_ids" {
    value = [for ngw in aws_nat_gateway.NATGW : ngw.id]
}

output "public_route_table_id" {
    value = aws_route_table.Public_RT.id
}

output "private_route_table_ids" {
    value = [
        aws_route_table.Private_RT1.id,
        aws_route_table.Private_RT2.id
    ]
}

output "nat_gateway_ids" {
    value = [for ngw in aws_nat_gateway.NATGW : ngw.id]
}

output "public_route_table_id" {
    value = aws_route_table.Public_RT.id
    }

    output "private_route_table_ids" {
    value = [
        aws_route_table.Private_RT1.id,
        aws_route_table.Private_RT2.id
    ]
}
