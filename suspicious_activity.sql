select userid, rating, count(*) as reviews_in_one_day,
to_timestamp(timestamp) :: date as review_date
from amazon_ratings
group by userid, rating, review_date
having count(*) >= 10 and rating in ('5', '1')
order by reviews_in_one_day desc;