# Day 10 - Terraform Security Group & SSH

## 오늘 배운 것
- Security Group = 서버 방화벽 (클럽 경비원)
- Key Pair = SSH 접속 열쇠
- 실제 AWS 서버 안으로 SSH 접속 성공!

## 만든 리소스 3개
1. aws_key_pair       → SSH 열쇠 AWS 등록
2. aws_security_group → 방화벽 (22번 포트 허용)
3. aws_instance       → EC2 서버

## 핵심 명령어
ssh -i ~/.ssh/devops-journey-key ubuntu@[IP주소]

## 내일 할 것
- Terraform VPC 구성
- Public/Private 서브넷 분리
