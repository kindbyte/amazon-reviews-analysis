SELECT 
 productId,
 COUNT(*) AS total_reviews,
 COUNT(DISTINCT userid) AS unique_users,
 ROUND(AVG(rating), 2) AS avg_rating
FROM amazon_ratings
GROUP BY productId
HAVING COUNT(*) >= 30 AND COUNT(DISTINCT userid) >= 25
ORDER BY avg_rating DESC
LIMIT 100;
