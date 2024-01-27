select artist, COUNT(*) as occurrences
from spotify
group by 1
order by 2 desc, 1
