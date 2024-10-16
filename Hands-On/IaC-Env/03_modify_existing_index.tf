# 03_modify_existing_index.tf

# 기존의 index.html 파일이 수정되었을 때, S3 버킷에 다시 업로드
resource "aws_s3_object" "modified_index" {
  bucket        = aws_s3_bucket.bucket1.id  # 버킷 이름 사용
  key           = "index.html"
  source        = "index.html"  # 수정된 index.html 파일 경로
  content_type  = "text/html"

  etag = filemd5("index.html")  # 파일이 변경되었을 때 업데이트
}
