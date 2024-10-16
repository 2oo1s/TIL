# AWS 제공자 설정
provider "aws" {
  region = "ap-northeast-2" 
}

# IAM 역할 생성
resource "aws_iam_role" "ce28_iam_role" {
  name = "ce28-iam-role"
  
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM 정책 정의 (S3에 대한 모든 권한 부여)
resource "aws_iam_policy" "s3_full_access_policy" {
  name        = "ce28-s3-full-access-policy"
  description = "Full access to S3 resources"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"  # 모든 S3 액세스 허용
        ]
        Resource = [
          "*"  # 모든 S3 리소스에 대한 권한
        ]
      }
    ]
  })
}

# IAM 역할에 정책 연결
resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.ce28_iam_role.name
  policy_arn = aws_iam_policy.s3_full_access_policy.arn
}
