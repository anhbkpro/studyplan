-- Approach 1: Grouping and Extracting the Minimum
select player_id, MIN(event_date) as first_login
from activity
group by 1

-- Approach 2: Using Window Functions
select distinct player_id, FIRST_VALUE(event_date) over (partition by player_id order by event_date) as first_login
from activity

-- Conclusion
-- Recommend Approach 1 due to its simplicity and how it naturally suggests
-- itself as a solution to this problem.

-- Approach 2 is useful in that it highlights many alternative solutions that
-- would be good to remark on in an interview context. If you encountered this
-- problem in an interview, then Approach 1 should be sufficient. But utilizing
-- any solution from Approach 2 should still leave a favorable impression on the
-- interviewer by suggesting you can find a solution to the problem at hand in
-- multiple ways, however sophisticated that way may need to be.
