variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr" {
  description = "VPC IP 범위"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet IP 범위"
  type        = string
  default     = "10.0.1.0/24"
}

variable "project_name" {
  description = "프로젝트 이름"
  type        = string
  default     = "devops-journey-day11"
}
