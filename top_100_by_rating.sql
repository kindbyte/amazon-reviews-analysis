WITH suspicious_users AS (
 SELECT userid
 FROM amazon_ratings
 GROUP BY userid, TO_TIMESTAMP(timestamp)::DATE
 HAVING COUNT(*) >= 10
),
clean_reviews AS (
 SELECT *
 FROM amazon_ratings
 WHERE userid NOT IN (SELECT userid FROM suspicious_users)
)
SELECT 
 productId,
 COUNT(*) AS total_reviews,
 ROUND(AVG(rating), 2) AS avg_rating
FROM clean_reviews
GROUP BY productId
HAVING COUNT(*) >= 30
ORDER BY avg_rating DESC
LIMIT 100;
