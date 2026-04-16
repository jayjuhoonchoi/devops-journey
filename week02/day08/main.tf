terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "ap-southeast-2"
}
resource "aws_s3_bucket" "my_first_bucket" {
  bucket = "devops-journey-jayjuhoon-2024"

  tags = {
    Name        = "My First Terraform Bucket"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}