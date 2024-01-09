select date_id, make_name, COUNT(distinct lead_id) as unique_leads, COUNT(distinct partner_id) as unique_partners
from dailysales
group by 1, 2
