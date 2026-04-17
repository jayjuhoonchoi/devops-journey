output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "ec2_public_ip" {
  description = "웹서버 EC2 퍼블릭 IP"
  value       = aws_instance.web.public_ip
}

output "rds_endpoint" {
  description = "DB 접속 주소"
  value       = aws_db_instance.postgres.endpoint
}

output "ssh_command" {
  description = "SSH 접속 명령어"
  value       = "ssh -i ~/.ssh/devops-journey-key ubuntu@${aws_instance.web.public_ip}"
}
