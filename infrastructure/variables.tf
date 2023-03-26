variable "aws_region" {
  default = "us-east-2"
}

variable "lambda_fun_name" {
  default = "IGTIexecutaEMRaovivo"
}

variable "key_pair_name" {
  default = "bit-igti-teste"
}

variable "airflow_subnet_id" {
  default = "subnet-4cef5427"
}

variable "vpc_id" {
  default = "vpc-d724b4bc"
}
