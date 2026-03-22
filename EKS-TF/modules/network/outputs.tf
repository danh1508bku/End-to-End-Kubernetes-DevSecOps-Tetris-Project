output "subnet_ids" {
  value = [data.aws_subnet.subnet.id, aws_subnet.public-subnet2.id]
}

output "security_group_ids" {
  value = [data.aws_security_group.sg-default.id]
}