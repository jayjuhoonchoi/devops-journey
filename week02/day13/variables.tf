variable "aws_region" {
  description = "AWS 리전"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "EC2 인스턴스 타입"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "EC2 서버 이름"
  type        = string
  default     = "devops-journey-day10"
}
