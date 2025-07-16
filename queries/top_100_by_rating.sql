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
