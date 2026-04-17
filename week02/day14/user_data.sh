#!/bin/bash
exec > /var/log/user_data.log 2>&1

apt-get update -y
apt-get install -y nginx docker.io

systemctl start docker
systemctl enable docker

cat > /var/www/html/index.html << HTML
<!DOCTYPE html>
<html>
<head><title>DevOps Journey</title></head>
<body style="font-family:sans-serif;text-align:center;padding:50px">
  <h1>Hello from AWS!</h1>
  <h2>Jay Choi | Melbourne DevOps Journey</h2>
  <p>Powered by: Terraform + Ansible + Docker + Nginx</p>
  <p>Day 14 Complete!</p>
</body>
</html>
HTML

systemctl restart nginx
systemctl enable nginx
