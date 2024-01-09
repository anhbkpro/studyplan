select distinct title
from tvprogram
left join content
using (content_id)
where Kids_content = 'Y'
and content_type = 'Movies'
and YEAR(program_date) = 2020
and MONTH(program_date) = 6

-- There are several ways to extract year and month from a date column
-- 1. use YEAR() and MONTH() functions: WHERE MONTH(program_date) = 6 AND YEAR(program_date)=2020
-- 2. use EXTRACT(YEAR_MONTH FROM date_column)
-- 3. use CONCAT(YEAR(date_column), '-', MONTH(date_column))
-- 4. use DATE_FORMAT(date_column, '%Y-%m'): WHERE DATE_FORMAT(program_date,'%Y-%m') = '2020-06'
-- 5. use STR_TO_DATE(date_column, '%Y-%m-%d')
-- 6. use SUBSTRING(date_column, 1, 7)
-- 7. use LEFT(date_column, 7): WHERE LEFT(program_date, 7) = '2020-06'
