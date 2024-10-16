# 02_upload_new_index.tf

# 새로운 index.html 파일을 S3 버킷에 업로드
resource "aws_s3_object" "index" {
  bucket        = aws_s3_bucket.bucket1.id  # 버킷 이름 사용
  key           = "index.html"
  source        = "index.html"  # 새로운 index.html 파일 경로
  content_type  = "text/html"

  etag = filemd5("index.html")  # 파일 변경 감지를 위한 etag 추가
}
