import logging
import sys

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, min, max, lit

# Configuracao de logs de aplicacao
logging.basicConfig(stream=sys.stdout)
logger = logging.getLogger('datalake_enem_small_upsert')
logger.setLevel(logging.DEBUG)

# Definicao da Spark Session
spark = (SparkSession.builder.appName("DeltaExercise")
    .config("spark.jars.packages", "io.delta:delta-core_2.12:1.0.0")
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
    .getOrCreate()
)


logger.info("Importing delta.tables...")
from delta.tables import *


logger.info("Produzindo novos dados...")
enemnovo = (
    spark.read.format("delta")
    .load("s3://datalake-ney-igti-edc-tf/staging-zone/enem")
)

# Define algumas inscricoes (chaves) que serao alteradas
inscricoes = [190001595656,
            190001421546,
            190001133210,
            190001199383,
            190001237802,
            190001782198,
            190001421548,
            190001595657,
            190001592264,
            190001592266,
            190001592265,
            190001475147,
            190001867756,
            190001133211,
            190001237803,
            190001493186,
            190001421547,
            190001493187,
            190001210202,
            190001421549,
            190001595658,
            190002037437,
            190001421550,
            190001595659,
            190001421551,
            190001237804,
            190001867757,
            190001184600,
            190001692704,
            190001867758,
            190002037438,
            190001595660,
            190001237805,
            190001705260,
            190001421552,
            190001867759,
            190001595661,
            190001042834,
            190001237806,
            190001595662,
            190001421553,
            190001475148,
            190001421554,
            190001493188,
            190002037439,
            190001421555,
            190001480442,
            190001493189,
            190001705261,
            190001421556]


logger.info("Reduz a 50 casos e faz updates internos no municipio de residencia")
enemnovo = enemnovo.where(enemnovo.NU_INSCRICAO.isin(inscricoes))
enemnovo = enemnovo.withColumn("NO_MUNICIPIO_RESIDENCIA", lit("NOVA CIDADE")).withColumn("CO_MUNICIPIO_RESIDENCIA", lit(10000000))


logger.info("Pega os dados do Enem velhos na tabela Delta...")
enemvelho = DeltaTable.forPath(spark, "s3://datalake-ney-igti-edc-tf/staging-zone/enem")


logger.info("Realiza o UPSERT...")
(
    enemvelho.alias("old")
    .merge(enemnovo.alias("new"), "old.NU_INSCRICAO = new.NU_INSCRICAO")
    .whenMatchedUpdateAll()
    .whenNotMatchedInsertAll()
    .execute()
)

logger.info("Atualizacao completa! \n\n")

logger.info("Gera manifesto symlink...")
enemvelho.generate("symlink_format_manifest")

logger.info("Manifesto gerado.")