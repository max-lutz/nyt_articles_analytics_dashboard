{{ config(materialized='table') }}


with dim_nyt_keywords as (
      SELECT article_id, arr_item as author
      FROM {{ ref('stg_nyt_data') }}, UNNEST(authors) as arr_item
      WHERE LENGTH(arr_item) > 2
)
SELECT * FROM dim_nyt_keywords