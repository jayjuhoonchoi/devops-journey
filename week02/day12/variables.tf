variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "VPC 전체 IP 범위"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet IP 범위 (웹서버용)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private Subnet IP 범위 (DB용)"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_2" {
  description = "Private Subnet 2 IP 범위 (RDS는 2개 AZ 필요)"
  type        = string
  default     = "10.0.3.0/24"
}

variable "project_name" {
  description = "프로젝트 이름"
  type        = string
  default     = "devops-journey-day12"
}

variable "db_password" {
  description = "DB 비밀번호"
  type        = string
  default     = "DevOps1234!"
  sensitive   = true
}
