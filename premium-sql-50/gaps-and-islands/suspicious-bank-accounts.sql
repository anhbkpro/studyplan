-- READ MORE: https://mattboegner.com/improve-your-sql-skills-master-the-gaps-islands-problem/

with

suspicious_accounts as (
select account_id, max_income,
    DATE_FORMAT(day, "%Y-%m-15") as tx_date,
    SUM(amount) as total_credit_per_month,
    CASE
        WHEN SUM(amount) > max_income THEN 1
        ELSE 0
    END as is_suspicious
from accounts a
join transactions t
using (account_id)
where t.type = 'Creditor'
group by account_id, DATE_FORMAT(day, "%Y-%m-15")
order by t.day
),

temp0 as (
    select account_id, tx_date, is_suspicious,
        DENSE_RANK() OVER (PARTITION BY account_id, is_suspicious order by tx_date) row_num
    from suspicious_accounts
    where is_suspicious = 1
),

temp1 as (
    select account_id, tx_date, row_num, is_suspicious,
        DATE_ADD(tx_date, INTERVAL -row_num MONTH) as groupings
    from temp0
)

select distinct account_id from temp1
group by account_id, groupings
HAVING(COUNT(*)) > 1
ORDER BY 1
