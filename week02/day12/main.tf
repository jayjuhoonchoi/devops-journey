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

# ============================================
# 1. VPC (도시 전체)
# ============================================
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "${var.project_name}-vpc" }
}

# ============================================
# 2. Internet Gateway (도시 정문)
# ============================================
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = { Name = "${var.project_name}-igw" }
}

# ============================================
# 3. Public Subnet (웹서버 구역)
# ============================================
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = { Name = "${var.project_name}-public" }
}

# ============================================
# 4. Private Subnet 1 (DB 구역 - AZ a)
# ============================================
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "${var.aws_region}a"

  tags = { Name = "${var.project_name}-private-1" }
}

# ============================================
# 5. Private Subnet 2 (DB 구역 - AZ b)
# RDS는 고가용성을 위해 2개 AZ에 걸쳐있어야 해요!
# ============================================
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_2
  availability_zone = "${var.aws_region}b"

  tags = { Name = "${var.project_name}-private-2" }
}

# ============================================
# 6. Elastic IP (NAT Gateway용 고정 IP)
# NAT Gateway는 고정 IP가 필요해요
# ============================================
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = { Name = "${var.project_name}-nat-eip" }
}

# ============================================
# 7. NAT Gateway (Private → 인터넷 단방향 통로)
# Public Subnet 안에 위치해야 해요!
# ============================================
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = { Name = "${var.project_name}-nat" }
}

# ============================================
# 8. Public Route Table (외부 트래픽 → IGW)
# ============================================
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = { Name = "${var.project_name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ============================================
# 9. Private Route Table (내부 트래픽 → NAT)
# Private은 IGW 대신 NAT Gateway로!
# ============================================
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = { Name = "${var.project_name}-private-rt" }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}

# ============================================
# 10. 웹서버 Security Group (SSH + HTTP 허용)
# ============================================
resource "aws_security_group" "web" {
  name   = "${var.project_name}-web-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-web-sg" }
}

# ============================================
# 11. DB Security Group (웹서버에서만 접근 허용!)
# 핵심! 인터넷에서 직접 DB 접근 불가
# ============================================
resource "aws_security_group" "db" {
  name   = "${var.project_name}-db-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    description     = "PostgreSQL from web server only"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    # 인터넷 전체(0.0.0.0/0)가 아닌
    # 웹서버 Security Group에서만 접근 허용!
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-db-sg" }
}

# ============================================
# 12. RDS Subnet Group
# RDS가 어느 Subnet에 위치할지 지정
# ============================================
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = { Name = "${var.project_name}-db-subnet-group" }
}

# ============================================
# 13. RDS PostgreSQL (실제 DB 서버!)
# ============================================
resource "aws_db_instance" "postgres" {
  identifier        = "${var.project_name}-db"
  engine            = "postgres"
  engine_version    = "15"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "devopsdb"
  username = "devopsadmin"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db.id]

  # 실습용 설정
  skip_final_snapshot = true   # 삭제 시 스냅샷 생략
  publicly_accessible = false  # 외부 접근 완전 차단!

  tags = { Name = "${var.project_name}-db" }
}

# ============================================
# 14. Key Pair + 최신 Ubuntu AMI
# ============================================
resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-key"
  public_key = file("~/.ssh/devops-journey-key.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }
}

# ============================================
# 15. EC2 웹서버 (Public Subnet에 위치)
# ============================================
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  key_name               = aws_key_pair.deployer.key_name

  tags = { Name = "${var.project_name}-web" }
}
