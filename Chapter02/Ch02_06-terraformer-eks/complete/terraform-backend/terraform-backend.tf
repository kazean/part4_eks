#s3 bucket
resource "aws_s3_bucket" "test-s3-tf-state" {

  bucket = "test-s3-tf-state"

  tags = {
    "Name" = "test-s3-tf-state"
  }
  
}

#lock dynamodb
resource "aws_dynamodb_table" "test-ddb-tf-lock" {
  #s3 bucket에 의존
  depends_on   = [aws_s3_bucket.test-s3-tf-state]
  name         = "test-ddb-tf-lock"
  #PAY_PER_REQUEST: 요청한만큼 과금(free tier), PROVISION..: 전용
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    "Name" = "test-ddb-tf-lock"
  }

}