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
