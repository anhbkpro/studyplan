select country_name,
CASE
    WHEN AVG(weather_state) <= 15 then 'Cold'
    WHEN AVG(weather_state) >= 25 then 'Hot'
    ELSE 'Warm'
END as weather_type
from countries
join weather
using (country_id)
where DATE_FORMAT(day, "%Y-%m") = "2019-11"
group by 1
