select s1.sale_date, (s1.sold_num - s2.sold_num) as diff
from sales s1
left join sales s2
on s1.sale_date = s2.sale_date and s1.fruit != s2.fruit
where s1.fruit != 'oranges'
