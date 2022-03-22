import boto3
import pandas as pd

# Criar um cliente para interagir com o AWS S3
s3_client = boto3.client('s3')

s3_client.download_file("datalake-hrpp-igti-edc",
                        "data/dimensao_mesorregioes_mg.csv",
                        "data/dimensao_mesorregioes_mg.csv")

df = pd.read_csv("data/dimensao_mesorregioes_mg.csv", sep=";")
print(df)

s3_client.upload_file("data/pnadc20203.csv",
                    "datalake-hrpp-igti-edc",
                    "data/pnadc20203.csv")