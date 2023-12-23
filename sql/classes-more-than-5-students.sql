with class_grouped as (
    select class, COUNT(student) as total
    from courses
    group by 1
)
select class from class_grouped where total >= 5;
