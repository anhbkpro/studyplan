select person_id, concat(name, "(", substr(profession, 1, 1), ")") as name
from person
order by 1 desc
