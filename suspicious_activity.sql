select userid, count(*) as reviews_in_one_day,
to_timestamp(timestamp) :: date as review_date
from amazon_ratings
group by userid, review_date
having count(*) >= 10
order by reviews_in_one_day desc;