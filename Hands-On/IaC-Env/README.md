# 🔮 IaC 기반 S3 버킷 생성 및 HTML 파일 자동화 프로세스

## 📌 실습 내용
- Terraform을 사용하여 AWS S3 버킷을 생성하고, 웹 호스팅을 위한 HTML 파일을 업로드하기

## 💡 실습 목표

- S3 버킷을 생성하고, HTML 파일을 사용자에게 제공할 수 있도록 웹 호스팅을 설정하기
  
- 여러 Terraform 파일을 사용하여 관리 및 유지보수의 효율성을 높이는 방법 이해하기

## 🧾 실습 과정

### 1️⃣ S3 버킷 생성

- S3 버킷을 생성하기 위한 Terraform 코드

  ```hcl
  resource "aws_s3_bucket" "bucket1" {
    bucket = "ce28-bucket1"  # 생성하고자 하는 S3 버킷 이름
  }

### 2️⃣ S3 버킷의 Public Access Block 설정

- 버킷의 공개 접근을 허용하는 설정을 추가하여, HTML 파일이 공용으로 접근 가능하도록 설정하기

```hcl
resource "aws_s3_bucket_public_access_block" "bucket1_public_access_block" {
  bucket = aws_s3_bucket.bucket1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
```

### 3️⃣ HTML 파일 업로드

- index.html과 main.html 파일을 S3 버킷에 업로드하기 위한 Terraform 코드

```hcl
resource "aws_s3_object" "index" {
  bucket        = aws_s3_bucket.bucket1.id 
  key           = "index.html"
  source        = "index.html"
  content_type  = "text/html"
}

resource "aws_s3_object" "main" {
  bucket        = aws_s3_bucket.bucket1.id 
  key           = "main.html"
  source        = "main.html"
  content_type  = "text/html"
}
```

### 4️⃣ S3 버킷 웹사이트 호스팅 설정

- S3 버킷을 웹사이트로 사용할 수 있도록 구성

```hcl
resource "aws_s3_bucket_website_configuration" "xweb_bucket_website" {
  bucket = aws_s3_bucket.bucket1.id  # 생성된 S3 버킷 이름 사용

  index_document {
    suffix = "index.html"
  }
}
```

### 5️⃣ S3 버킷의 Public Read 정책 설정

- HTML 파일에 대한 공용 읽기 접근을 허용하는 정책을 추가

```hcl
resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.bucket1.id  # 생성된 S3 버킷 이름 사용

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "arn:aws:s3:::ce28-bucket1",
        "arn:aws:s3:::ce28-bucket1/*"
      ]
    }
  ]
}
EOF
}
```

### 6️⃣ Terraform 실행

- 설정을 적용하여 AWS 리소스를 생성하기 위해 Terraform을 실행

```bash
terraform init
terraform plan
terraform apply
```

### 🎇 결과

- index.html을 변경했을 때, 아래 사진과 같이 변경사항이 반영되어 수정시간이 main.html과 다른 것을 확인할 수 있음

![image](https://github.com/user-attachments/assets/a80a5875-5571-4d35-bcb4-aa6aa64ee166)
