-- create keywords table
SELECT DISTINCT(arr_item) 
FROM `nyt-data-analytics.nyt_data.nyt_data_raw`, 
UNNEST(keywords) as arr_item

-- create author table
SELECT DISTINCT(arr_item)
FROM `nyt-data-analytics.nyt_data.nyt_data_raw`, 
UNNEST(author) as arr_item
LIMIT 10;

-- fact table
SELECT _id, `source`, headline, pub_date, document_type, news_desk, section_name, word_count
FROM `nyt-data-analytics.nyt_data.nyt_data_raw`
LIMIT 10


-- create article_to_keyword table
SELECT _id, arr_item
FROM `nyt-data-analytics.nyt_data.nyt_data_raw`, 
UNNEST(keywords) as arr_item
WHERE LENGTH(arr_item) > 2

-- create author_to_keyword table
SELECT _id, arr_item
FROM `nyt-data-analytics.nyt_data.nyt_data_raw`, 
UNNEST(author) as arr_item
WHERE LENGTH(arr_item) > 2
