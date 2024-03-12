{{
    config(
        materialized='view'
    )
}}

with nyt_data as 
(
  select *
  from {{ source('staging','nyt_data_raw') }}
)
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['_id']) }} as article_id,
    
    -- timestamps
    cast(pub_date as timestamp) as published_date,
    
    -- article info
    {{ dbt.safe_cast("word_count", api.Column.translate_type("integer")) }} as word_count,

    'source' as article_source, 
    headline,
    document_type, 
    news_desk, 
    section_name

from tripdata


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 10

{% endif %}