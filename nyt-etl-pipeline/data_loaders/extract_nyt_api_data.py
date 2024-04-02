import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test
from mage_ai.data_preparation.shared.secrets import get_secret_value

columns_to_keep = ['_id', 'source', 'headline', 'keywords', 'pub_date', 'document_type',
                        'news_desk', 'section_name', 'byline', 'word_count']


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """

    parameters = {'api-key': get_secret_value('nyt_key')}

    now_datetime = pd.to_datetime(kwargs['execution_date'])
    year = now_datetime.year
    month = now_datetime.month

    url = f"https://api.nytimes.com/svc/archive/v1/{year}/{month}.json"
    response = requests.get(url, params=parameters)

    json = response.json()

    return pd.DataFrame(json['response']['docs'])


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'

@test
def test_column_number(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert all(col in  output.columns for col in columns_to_keep), 'Missing important columns'