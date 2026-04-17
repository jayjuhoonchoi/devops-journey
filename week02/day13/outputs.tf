output "instance_public_ip" {
  description = "EC2 퍼블릭 IP"
  value       = aws_instance.my_server.public_ip
}

output "ssh_command" {
  description = "SSH 접속 명령어 자동 출력"
  value       = "ssh -i ~/.ssh/devops-journey-key ubuntu@${aws_instance.my_server.public_ip}"
}
