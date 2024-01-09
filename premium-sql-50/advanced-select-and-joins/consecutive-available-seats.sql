with consecutive_seats as
(
    select c1.seat_id as seat1, c2.seat_id as seat2
    from cinema c1
    left join cinema c2
    on c2.seat_id = c1.seat_id + 1
    and c2.free = 1 and c1.free = 1
    where c2.seat_id is not null
)
select *
from
(
    select seat1 as seat_id
    from consecutive_seats
    union
    select seat2 as seat_id
    from consecutive_seats
) s
order by 1

-- Leetcode solution: Approach: Using self join and abs()[Accepted]
select distinct a.seat_id
from cinema a join cinema b
  on abs(a.seat_id - b.seat_id) = 1
  and a.free = true and b.free = true
order by a.seat_id
