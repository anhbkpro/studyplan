with most_voted as
(
    select candidateId, COUNT(*)
    from vote
    group by 1
    order by 2 desc
    limit 1
)
select name
from candidate
where id in (select candidateId from most_voted)
