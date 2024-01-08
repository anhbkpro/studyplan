with ranked as
(
  select student_id,
    course_id,
    grade,
    DENSE_RANK() over (partition by student_id order by grade desc, course_id) as rnk
  from enrollments
)
select student_id, course_id, grade
from ranked
where rnk = 1
