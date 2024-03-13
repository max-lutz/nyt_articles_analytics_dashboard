{{ config(materialized='table') }}


with dim_nyt_keywords as (
      SELECT article_id, arr_item as keyword
      FROM {{ ref('stg_nyt_data') }}, UNNEST(keywords) as arr_item
      WHERE LENGTH(arr_item) > 2
)
SELECT * FROM dim_nyt_keywords