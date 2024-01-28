with avg_by_event as (
    select event_type, AVG(occurrences) as average_activity
    from events
    group by event_type
)

select business_id
from events e
join avg_by_event a
using (event_type)
where e.occurrences > a.average_activity
group by business_id
having COUNT(*) > 1
