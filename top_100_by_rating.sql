select productId, count(*) as total_reviews,
round(avg(rating), 2) as avg_rating
from amazon_ratings
group by productId
having count(*) >= 30
order by avg_rating DESC limit 100;
