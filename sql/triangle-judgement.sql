select
    *,
    CASE
        WHEN (x + y > z) && (x + z > y) && (z + y > x) THEN 'Yes'
        ELSE 'No'
    END as triangle
from triangle
