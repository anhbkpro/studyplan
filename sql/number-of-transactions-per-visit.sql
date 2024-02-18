-- this t table calculates the number of transactions for each user, for each visit (including if the user had zero transactions for that visit)
with t as (
  select
    v.user_id as user_id,
    visit_date,
    if(transaction_date is null, 0, count(*)) as transaction_count
  from visits v
  left join transactions t
  on v.visit_date = t.transaction_date and v.user_id = t.user_id
  group by 1, 2
),

-- this simply generates a table with numbers from zero to [number of rows in transactions table]
-- this will be necessary later to deal with edge cases for when there are zero of that number of transactions
-- but we still want to see that in the end result (eg there were zero cases of two-transactions but there were cases with three-transactions)
row_nums as (
  select row_number() over () as rn
  from transactions
  union
  select 0
)

-- if transaction_count is null (due to the right join below), then insert a zero, otherwise simply count the times that number appears
select
  rn as transactions_count,
  if(transaction_count is null, 0, count(*)) as visits_count
-- right join on row_nums (right join because we don't want to lose, for example, two-transactions being zero)
from t
right join row_nums on transaction_count = rn
-- we can remove excess transaction-numbers (eg if the max transaction-number is four, we don't need five+ in our end result)
where rn <= (select max(transaction_count) from t)
group by rn
order by 1
