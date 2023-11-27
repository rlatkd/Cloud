# rlatkd_react_bucket 생성
resource "aws_s3_bucket" "rlatkd_react_bucket" {
  bucket = "rlatkd-react-bucket"
}

resource "aws_s3_bucket_public_access_block" "rlatkd_react_bucket_access_block" {
  bucket                  = aws_s3_bucket.rlatkd_react_bucket.bucket
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
