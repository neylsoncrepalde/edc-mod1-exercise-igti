resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  name        = "igti-kinesis-firehose-s3-stream"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose_role.arn
    bucket_arn = aws_s3_bucket.stream.arn
    prefix = "firehose/"
    buffer_size = 64
    buffer_interval = 60
    
    data_format_conversion_configuration {
      input_format_configuration {
        deserializer {
          hive_json_ser_de {}
        }
      }

      output_format_configuration {
        serializer {
          parquet_ser_de {}
        }
      }

      schema_configuration {
        database_name = aws_glue_catalog_database.stream.name
        role_arn      = aws_iam_role.firehose_role.arn
        table_name    = aws_glue_catalog_table.stream_table.name
      }
    }

  }
}


resource "aws_iam_role" "firehose_role" {
  name = "IGTI_firehose_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
