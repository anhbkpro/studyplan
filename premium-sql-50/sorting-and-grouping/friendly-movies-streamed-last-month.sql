select distinct title
from tvprogram
left join content
using (content_id)
where Kids_content = 'Y'
and content_type = 'Movies'
and YEAR(program_date) = 2020
and MONTH(program_date) = 6
