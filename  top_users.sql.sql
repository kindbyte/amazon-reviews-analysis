select userid, count(*) as total_reviews, round(avg(rating),2) as average_rating
from amazon_ratings
group by userid
order by total_reviews desc limit 30;