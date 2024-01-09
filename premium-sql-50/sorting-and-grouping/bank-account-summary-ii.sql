select *
from
(
    select name, SUM(amount) as balance
    from users
    left join transactions
    using (account)
    group by 1
) g
where balance > 10000
