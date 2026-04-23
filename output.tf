output "vpc" {
  value = aws_vpc.ec2vpc.id
}

output "public_subnet" {
  value = aws_subnet.public[*].id
}

output "private_subnet" {
  value = aws_subnet.private[*].id
}

output "web_server_ip" {
  value = aws_instance.web.public_ip
}

output "web_server_ssh" {
  value = format("ssh %s@%s", var.web_server_info.username, aws_instance.web.public_ip)
  #value = "ssh ${var.web_server_info.username}@${aws_instance.web.public_ip}"
}