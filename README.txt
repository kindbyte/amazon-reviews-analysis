Amazon Ratings: Cleaning Suspicious Reviews & Honest Product Rankings
📋 Project Overview
This mini-project focuses on identifying and removing suspicious user behavior from the amazon_ratings dataset to build a more accurate Top 100 Product Ratings list. The goal is to ensure that product ratings are not influenced by artificial review inflation.

🎯 Objectives
	•	Detect suspicious users who may be inflating product ratings by leaving multiple extreme reviews (5 or 1 stars) within a single day.
	•	Exclude those users and their reviews from further analysis.
	•	Recalculate product ratings using only clean, trustworthy reviews.

Step 1: Detect Suspicious Reviewers
sql

SELECT 
  userid, 
  rating, 
  COUNT(*) AS reviews_in_one_day,
  TO_TIMESTAMP(timestamp)::date AS review_date
FROM amazon_ratings
GROUP BY userid, rating, review_date
HAVING COUNT(*) >= 10 AND rating IN ('5', '1')
ORDER BY reviews_in_one_day DESC;

✔️ This query identifies users who left 10 or more reviews with either 5 or 1 star ratings on the same day — a common signal of spam-like or manipulated behavior.

Step 2: Clean the Dataset & Recalculate Rankings
sql

WITH suspicious_users AS (
  SELECT 
    userid, 
    rating, 
    COUNT(*) AS reviews_in_one_day,
    TO_TIMESTAMP(timestamp)::date AS review_date
  FROM amazon_ratings
  GROUP BY userid, rating, review_date
  HAVING COUNT(*) >= 10 AND rating IN ('5', '1')
),

clean_reviews AS (
  SELECT * 
  FROM amazon_ratings
  WHERE userid NOT IN (
    SELECT userid FROM suspicious_users
  )
)

SELECT 
  productid, 
  COUNT(*) AS total_reviews, 
  ROUND(AVG(rating), 2) AS avg_rating
FROM clean_reviews
GROUP BY productid
HAVING COUNT(*) > 50
ORDER BY avg_rating DESC
LIMIT 100;

✔️ This logic removes reviews from suspicious users and recalculates the Top 100 products based on:
	•	Average rating
	•	Minimum threshold of 50 reviews per product
