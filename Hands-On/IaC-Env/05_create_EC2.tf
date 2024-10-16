# 05_create_EC2.tf

# AWS Provider 설정
provider "aws" {
  region = "ap-northeast-2"  # 서울 리전
}

# EC2 인스턴스 생성
resource "aws_instance" "web" {
  ami           = "ami-047f7b46bd6dd5d84"  # Amazon Linux 2 AMI for ap-northeast-2
  instance_type = "t2.micro"  # 프리티어 사용 가능

  # 인스턴스에 태그 지정 (이름을 ce28-ec2로 설정)
  tags = {
    Name = "ce28-ec2"
  }
}

# EC2 인스턴스의 Public IP
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}
