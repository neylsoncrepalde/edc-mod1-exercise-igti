resource "aws_glue_catalog_database" "stream" {
  name = "streamingdb"
}



resource "aws_glue_catalog_table" "stream_table" {
  name          = "igti_stream_table"
  database_name = aws_glue_catalog_database.stream.name

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL = "TRUE"
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.stream.id}/firehose"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"

    ser_de_info {
      name                  = "igti-stream"
      serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"

      parameters = {
        "serialization.format" = 1
      }
    }

    columns {
      name = "event_id"
      type = "string"
    }

    columns {
      name = "event_timestamp"
      type = "timestamp"
    }

    columns {
      name    = "event_type"
      type    = "string"
    }

    columns {
      name    = "page_url"
      type    = "string"
    }

    columns {
      name    = "page_url_path"
      type    = "string"
    }
    columns {
      name    = "referer_url"
      type    = "string"
    }
    columns {
      name    = "referer_url_schema"
      type    = "string"
    }
    columns {
      name    = "referer_url_port"
      type    = "int"
    }
    columns {
      name    = "referer_medium"
      type    = "string"
    }
    columns {
      name    = "utm_medium"
      type    = "string"
    }
    columns {
      name    = "utm_source"
      type    = "string"
    }
    columns {
      name    = "utm_content"
      type    = "string"
    }
    columns {
      name    = "utm_campaign"
      type    = "string"
    }
    columns {
      name    = "click_id"
      type    = "string"
    }
    columns {
      name    = "geo_latitude"
      type    = "double"
    }
    columns {
      name    = "geo_longitude"
      type    = "double"
    }
    columns {
      name    = "geo_country"
      type    = "string"
    }
    columns {
      name    = "geo_timezone"
      type    = "string"
    }
    columns {
      name    = "geo_region_name"
      type    = "string"
    }
    columns {
      name    = "ip_address"
      type    = "string"
    }
    columns {
      name    = "browser_name"
      type    = "string"
    }
    columns {
      name    = "browser_user_agent"
      type    = "string"
    }
    columns {
      name    = "browser_language"
      type    = "string"
    }
    columns {
      name    = "os"
      type    = "string"
    }
    columns {
      name    = "os_name"
      type    = "string"
    }
    columns {
      name    = "os_timezone"
      type    = "string"
    }
    columns {
      name    = "device_type"
      type    = "string"
    }
    columns {
      name    = "device_is_mobile"
      type    = "bool"
    }
    columns {
      name    = "user_custom_id"
      type    = "string"
    }
    columns {
      name    = "user_domain_id"
      type    = "string"
    }

  }
}