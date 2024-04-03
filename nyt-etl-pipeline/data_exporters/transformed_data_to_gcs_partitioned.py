import pyarrow as pa
import pyarrow.parquet as pq
import os
from dotenv import load_dotenv

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/personal-gcp.json'

dotenv_path = '/home/src/.env'
load_dotenv(dotenv_path)
project_id = os.environ.get('PROJECT_ID')

bucket_name = f'bucket-{project_id}'
table_name ='nyt_raw_data'

root_path = f'{bucket_name}/{table_name}'

@data_exporter
def export_data(data, *args, **kwargs):
    table = pa.Table.from_pandas(data)

    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols = ['pub_date'],
        filesystem = gcs
    )