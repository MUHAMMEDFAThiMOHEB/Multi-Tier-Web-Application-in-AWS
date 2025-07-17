output "EC2_SG" {
    value = aws_security_group.sg-ec2.id
}

output "ALB_SG" {
    value = aws_security_group.ALBSG.id
}