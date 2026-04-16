output "instance_public_ip" {
  description = "EC2 퍼블릭 IP 주소"
  value       = aws_instance.my_server.public_ip
}

output "instance_id" {
  description = "EC2 인스턴스 ID"
  value       = aws_instance.my_server.id
}