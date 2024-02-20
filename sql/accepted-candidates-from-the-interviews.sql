with MoreThan2YearsOfExperience as (
    select candidate_id, name, years_of_exp, interview_id
    from candidates
    where years_of_exp >= 2
)

select candidate_id
from MoreThan2YearsOfExperience
join Rounds using (interview_id)
group by candidate_id
having SUM(score) > 15
