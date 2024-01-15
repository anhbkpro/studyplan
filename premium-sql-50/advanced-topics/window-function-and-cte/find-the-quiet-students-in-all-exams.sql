with lowest as
(
    select * from
    (
        select student_id, exam_id, score,
            DENSE_RANK() over (PARTITION BY exam_id order by score) as rnk
        from
        exam
    ) d
    where d.rnk = 1
),
highest as (
    select * from
    (
        select student_id, exam_id, score,
            DENSE_RANK() over (PARTITION BY exam_id order by score desc) as rnk
        from
        exam
    ) d
    where d.rnk = 1
)
select distinct student_id, student_name from
student s
inner join exam e
using (student_id)
where student_id not in
(
    select student_id from lowest
    union
    select student_id from highest
)
order by 1
