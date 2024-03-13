import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test
from mage_ai.data_preparation.shared.secrets import get_secret_value


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """

    parameters = {'api-key': get_secret_value('nyt_key')}

    url = "https://api.nytimes.com/svc/archive/v1/2019/1.json"
    response = requests.get(url, params=parameters)

    json = response.json()

    return pd.DataFrame(json['response']['docs'])


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'