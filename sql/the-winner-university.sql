with excellent_newyork_students as (
    select COUNT(*) as count, "New York University" as university
    from newyork
    where score >= 90
),
excellent_california_students as (
    select COUNT(*) as count, "California University" as university
    from california
    where score >= 90
)
select
    CASE
        WHEN n.count > c.count THEN n.university
        WHEN n.count < c.count THEN c.university
        ELSE "No Winner"
    END as winner
from excellent_newyork_students n
cross join excellent_california_students c
