# Example of insecure Terraform code
provider "aws" {
  region = "us-east-1"
}

# Insecure S3 bucket
resource "aws_s3_bucket" "insecure_bucket" {
  bucket = "insecure-public-bucket"
  acl    = "public-read" # Insecure: Publicly readable bucket

  versioning {
    enabled = false # Insecure: No versioning for data protection
  }

  tags = {
    Name = "Insecure S3 Bucket"
  }
}

# Hardcoded secrets
resource "aws_secretsmanager_secret" "insecure_secret" {
  name       = "hardcoded-secret"
  description = "A hardcoded secret"
  secret_string = "super_secret_password" # Insecure: Hardcoded sensitive data
}

# EC2 instance with overly permissive security group
resource "aws_security_group" "insecure_sg" {
  name        = "insecure-sg"
  description = "Insecure security group with open access"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Insecure: Open to the world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Insecure: Open to the world
  }

  tags = {
    Name = "Insecure SG"
  }
}

resource "aws_instance" "insecure_instance" {
  ami           = "ami-12345678" # Example AMI
  instance_type = "t2.micro"

  security_groups = [aws_security_group.insecure_sg.name]

  tags = {
    Name = "Insecure EC2 Instance"
  }
}
