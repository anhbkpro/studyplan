select id,
(
    case
        when p_id is null then "Root"
        when id in (select p_id from tree) then "Inner"
        else "Leaf"
    end
) as type
from tree

-- Approach: Using IF function
select id,
(
    if(p_id is null, "Root",
    if(id in (select p_id from tree), "Inner", "Leaf"))
) as type
from tree
