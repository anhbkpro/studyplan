select email
from person
where id in
(
    select id
    from person
    group by email
    having COUNT(id) > 1
)
