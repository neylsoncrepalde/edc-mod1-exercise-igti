resource "aws_s3_bucket" "dl" {
  bucket = "datalake-ney-igti-edc-tf"
  acl    = "private"

  tags = {
    IES   = "IGTI",
    CURSO = "EDC"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "stream" {
  bucket = "igti-ney-streaming-bucket"
  acl    = "private"

  tags = {
    IES   = "IGTI",
    CURSO = "EDC"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
