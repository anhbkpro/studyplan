with books_sold_last_year as (
    select book_id, sum(quantity) as book_sold
    from orders
    where dispatch_date between '2018-06-23' and '2019-06-23'
    group by book_id
)

select b.book_id, b.name
from books b
left join books_sold_last_year s
using (book_id)
where available_from < '2019-05-23'
and (book_sold is null or book_sold < 10)
order by 1
