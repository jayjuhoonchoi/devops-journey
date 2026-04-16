terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# 어제랑 다른 점!
# region에 직접 "ap-southeast-2" 쓰는 대신
# var.aws_region 변수를 참조함
provider "aws" {
  region = var.aws_region
}

# 최신 Ubuntu 22.04 AMI 자동으로 찾기
# AMI = EC2 서버의 OS 이미지 (윈도우 설치 USB 같은 것)
# 직접 AMI ID 찾아서 입력하는 대신
# data로 자동으로 최신 버전 찾아옴!
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Ubuntu 공식 계정 ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

# EC2 인스턴스 생성
# EC2 = AWS에서 빌리는 가상 서버
resource "aws_instance" "my_server" {
  ami           = data.aws_ami.ubuntu.id  # 위에서 찾은 Ubuntu AMI 자동 적용
  instance_type = var.instance_type       # variables.tf에서 t2.micro 가져옴

  tags = {
    Name      = var.instance_name
    ManagedBy = "Terraform"
    Day       = "09"
  }
}