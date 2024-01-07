-- 570. Managers with at Least 5 Direct Reports
-- Find the names of all managers who have at least 5 direct reports. Include the names of the managers and the number of direct reports they have.
-- Output the result table ordered by number of direct reports in descending order.
-- The query result format is in the following example:
-- Input:
-- Employee table:
-- +-----+-------+------------+-----------+
-- | id  | name  | department | managerId |
-- +-----+-------+------------+-----------+
-- | 101 | John  | A          | null      |
-- | 102 | Dan   | A          | 101       |
-- | 103 | James | A          | 101       |
-- | 104 | Amy   | A          | 101       |
-- | 105 | Anne  | A          | 101       |
-- | 106 | Ron   | B          | 101       |
-- +-----+-------+------------+-----------+
-- Output:
-- +------+
-- | name |
-- +------+
-- | John |
-- +------+
-- Explanation:
-- John is the only manager who has at least 5 direct reports.

-- Write your MySQL query statement below
select name
from employee
where id in (
    select managerId
    from employee
    group by managerId
    having count(*) >= 5
)
