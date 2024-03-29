{{ config(materialized='table') }}

with fact_nyt_articles as (
    select article_id,
    published_date,
    extract(YEAR FROM published_date) as published_year,
    format_date('%B', published_date) as published_month,
    word_count,
    article_source,
    headline,
    document_type,
    news_desk,
    section_name
    from {{ ref('stg_nyt_data') }}
)

select * from fact_nyt_articles