select transaction_id
from (
    select transaction_id,
        DENSE_RANK() OVER (PARTITION BY DATE_FORMAT(day, "%Y-%m-%d") order by amount desc) as rnk
    from transactions
) t
where t.rnk = 1
order by 1
