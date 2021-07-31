resource "aws_cloudwatch_log_group" "firehose" {
  name              = "kinesis-firehose-delivery-stream-log-group"
  retention_in_days = 1

  tags = {
    IES   = "IGTI"
    CURSO = "EDC"
  }
}


resource "aws_cloudwatch_log_stream" "firehose" {
  name           = "kinesis-firehose-delivery-stream-log-stream"
  log_group_name = aws_cloudwatch_log_group.firehose.name
}