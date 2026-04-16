output "instance_public_ip" {
  value = aws_instance.my_server.public_ip
}

output "ssh_command" {
  value = "ssh -i ~/.ssh/devops-journey-key ubuntu@${aws_instance.my_server.public_ip}"
}
