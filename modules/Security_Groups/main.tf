#* Security group for EC2 instances
resource "aws_security_group" "sg-ec2" {
    name = "WebSG"
    description = "allow HTTP inbound and all traffic outbound"
    vpc_id = var.vpc_id

    tags = {
        Name = "EC2 instances SG"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
    security_group_id = aws_security_group.sg-ec2.id
    cidr_ipv4 = var.cidr_global
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
    security_group_id = aws_security_group.WebSG.id
    cidr_ipv4 = var.cidr_global
    ip_protocol       = "-1" 
}

resource "aws_security_group" "ALBSG" {
    name        = "ALBSG"
    description = "Allow HTTP for inbound traffic and all outbound traffic"
    vpc_id      = var.vpc_id

    tags = {
        Name = "ALBSG"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4_ALB" {
    security_group_id = aws_security_group.ALBSG.id
    cidr_ipv4 = var.cidr_global
    from_port         = 80
    ip_protocol       = "tcp"
    to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_ALB" {
    security_group_id = aws_security_group.ALBSG.id
    cidr_ipv4 = var.cidr_global
    ip_protocol       = "-1" 
}