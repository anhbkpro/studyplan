with recursive id_seq as (
    select 1 as continued_id
    union
    select continued_id + 1
    from id_seq
    where continued_id < (select max(customer_id) from customers)
)

select continued_id as ids
from id_seq
where continued_id not in (select customer_id from customers)
