with MemberTotalAmount as (
    select m.member_id, m.name,
        100 * SUM(CASE WHEN IFNULL(charged_amount, 0) > 0 THEN 1 ELSE 0 END) / COUNT(*) as total
    from members m
    left join visits v
    using (member_id)
    left join purchases p
    using (visit_id)
    group by 1, 2
),

VisitedMembers as (
    select distinct member_id from Visits
)

select member_id, name,
    CASE
        WHEN member_id not in (select * from VisitedMembers) THEN 'Bronze'
        WHEN total >= 80 THEN 'Diamond'
        WHEN total >= 50 and total < 80 THEN 'Gold'
        ELSE 'Silver'
    END as category
from MemberTotalAmount
order by 1

-- Solution 2
select
  m.member_id,
  m.name,
  case
    when v.member_id is null then 'Bronze'
    when sum(case when p.charged_amount > 0 then 1 else 0 end) / count(*) >= 0.8 then 'Diamond'
    when sum(case when p.charged_amount > 0 then 1 else 0 end) / count(*) >= 0.5 then 'Gold'
    else 'Silver'
  end as category
from members m
left join visits v
on m.member_id = v.member_id
left join purchases p
on v.visit_id = p.visit_id
group by 1, 2
order by 1
