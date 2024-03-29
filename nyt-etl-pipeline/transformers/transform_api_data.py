import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.

    Add more parameters to this function if this block has multiple parent blocks.
    There should be one parameter for each output variable from each parent block.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        Anything (e.g. data frame, dictionary, array, int, str, etc.)
    """
    
    # remove columns
    data = data[columns_to_keep]

    # extract nested data
    data['headline'] = data['headline'].apply(lambda x: x.get('main'))

    data['author'] = data['byline'].apply(lambda x: x.get('person'))
    data['author'] = data['author'].apply(
        lambda x: [d.get('firstname') + ' ' + d.get('lastname') for d in x])

    data['keywords'] = data['keywords'].apply(lambda x: [d.get('value') for d in x])

    columns_to_keep = ['_id', 'source', 'headline', 'keywords', 'pub_date', 'document_type',
                        'news_desk', 'section_name', 'author', 'word_count']
    data = data[columns_to_keep]

    # convert date column to correct
    data['pub_date'] = pd.to_datetime(data['pub_date']).dt.date

    print(data.info())

    return data


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
    assert len(output.columns) == 10, 'The number of transformed columns is incorrect'