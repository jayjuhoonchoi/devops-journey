output "vpc_id" {
  description = "생성된 VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}

output "ec2_public_ip" {
  description = "EC2 퍼블릭 IP"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "SSH 접속 명령어"
  value       = "ssh -i ~/.ssh/devops-journey-key ubuntu@${aws_instance.web.public_ip}"
}
