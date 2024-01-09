with durations as
(
    select caller_id as user, duration
    from calls
    union all
    select callee_id as user, duration
    from calls
)
select c.name as country
from country c
left join person p
on c.country_code = LEFT(p.phone_number, 3)
join durations d
on p.id = d.user
group by c.name
HAVING AVG(d.duration) > (select AVG(duration) from durations)
