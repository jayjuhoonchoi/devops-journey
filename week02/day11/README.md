# Day 11 - Terraform VPC 네트워크 구성

## 오늘 배운 것
- VPC = 나만의 AWS 네트워크 도시
- Subnet = 도시 안의 구역
- Internet Gateway = 인터넷 연결 문
- Route Table = 교통 규칙
- 내가 만든 VPC 안의 EC2에 SSH 접속 성공!

## 만든 리소스 8개
1. aws_vpc                    → 네트워크 도시
2. aws_internet_gateway       → 인터넷 문
3. aws_subnet                 → Public 구역
4. aws_route_table            → 교통 규칙
5. aws_route_table_association → 구역에 규칙 연결
6. aws_security_group         → 방화벽
7. aws_key_pair               → SSH 열쇠
8. aws_instance               → EC2 서버

## VPC 구조
인터넷 🌏
    │
Internet Gateway
    │
VPC (10.0.0.0/16)
    │
Public Subnet (10.0.1.0/24)
    │
EC2 서버

## 내일 할 것
- Private Subnet 추가
- NAT Gateway 구성
- 진짜 실무 네트워크 완성
