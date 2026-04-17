terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 공개 열쇠를 AWS에 등록
# "This is how AWS knows who's allowed to enter"
resource "aws_key_pair" "deployer" {
  key_name   = "devops-journey-key"
  public_key = file("~/.ssh/devops-journey-key.pub")
}

# Security Group = 서버 방화벽
# "Think of it as a bouncer at a club"
# (클럽 입구 경비원 같은 것, 허용된 사람만 들여보냄)
resource "aws_security_group" "my_sg" {
  name        = "devops-journey-sg"
  description = "Allow SSH access"

  # 들어오는 트래픽 규칙
  ingress {
    description = "SSH from anywhere"
    from_port   = 22      # SSH 포트
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 어디서든 접근 허용
  }

  # 나가는 트래픽 규칙
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"            # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]  # 어디든 나갈 수 있음
  }
}

# 최신 Ubuntu AMI 자동 조회
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

# EC2 생성
resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.my_sg.id]

  tags = {
    Name      = var.instance_name
    ManagedBy = "Terraform"
    Day       = "10"
  }
}
