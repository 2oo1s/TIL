# 01_create_bucket.tf

# S3 버킷 생성
resource "aws_s3_bucket" "bucket1" {
  bucket = "ce28-bucket1"  # 생성하고자 하는 S3 버킷 이름
}

# S3 버킷의 public access block 설정
resource "aws_s3_bucket_public_access_block" "bucket1_public_access_block" {
  bucket = aws_s3_bucket.bucket1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# S3 버킷의 웹사이트 호스팅 설정
resource "aws_s3_bucket_website_configuration" "xweb_bucket_website" {
  bucket = aws_s3_bucket.bucket1.id  # 생성된 S3 버킷 이름 사용

  index_document {
    suffix = "index.html"  # 기본 문서 설정
  }
}
