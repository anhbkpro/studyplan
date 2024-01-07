select
    DATE_FORMAT(trans_date,'%Y-%m') as month,
    country,
    COUNT(id) as trans_count,
    COUNT(case when state = 'approved' then 1 end) as approved_count,
    SUM(amount) as trans_total_amount,
    SUM(ifnull((case when state = 'approved' then amount end),0)) as approved_total_amount
from transactions
group by 1, 2;
