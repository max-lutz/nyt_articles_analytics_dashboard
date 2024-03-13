{{ config(materialized='table') }}

with fact_nyt_articles as (
    select article_id,
    published_date, 
    word_count,
    article_source,
    headline,
    document_type,
    news_desk,
    section_name
    from {{ ref('stg_nyt_data') }}
)

select * from fact_nyt_articles