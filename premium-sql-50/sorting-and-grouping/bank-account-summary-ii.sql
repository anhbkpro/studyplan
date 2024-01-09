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

-- refactor: use having instead of where
select name, SUM(amount) as balance
from users
left join transactions
using (account)
group by 1
having SUM(amount) > 10000
