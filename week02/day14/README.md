# Day 14 - Terraform + 자동 배포

## 오늘 배운 것
- user_data = EC2 시작 시 자동 실행 스크립트
- terraform apply 한 번으로 전부 자동화
- 실제 인터넷에서 접근 가능한 웹페이지 배포!

## 자동화 흐름
terraform apply
    → EC2 생성
    → user_data 자동 실행
    → Nginx + Docker 설치
    → 웹페이지 배포
    → 인터넷 접속 가능!

## 핵심 개념
user_data = 서버 시작 시 자동 실행 스크립트

## 내일 할 것
- GitHub Actions CI/CD
- 코드 push → 자동 배포!
