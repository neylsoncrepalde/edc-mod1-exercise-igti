# psycopg2 library is necessary
import pandas as pd
from sqlalchemy import create_engine
import os

engine = create_engine(
    f"postgresql://neylsoncrepalde:{os.environ['PGPASS']}@database-igti.cfowiwu0gidv.us-east-2.rds.amazonaws.com:5432/postgres"
)

df = pd.read_csv("data/pnadc20203.csv", sep=';')

df.to_sql('pnadc20203', con=engine, if_exists='replace', index=False, chunksize=10000)
