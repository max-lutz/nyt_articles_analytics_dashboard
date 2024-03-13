-- create keywords table
SELECT DISTINCT(arr_item) 
FROM `nyt-data-analytics.nyt_data.nyt_data_raw`, 
UNNEST(keywords) as arr_item

-- create author table
SELECT DISTINCT(arr_item)
FROM `nyt-data-analytics.nyt_data.nyt_data_raw`, 
UNNEST(author) as arr_item
LIMIT 10;


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
