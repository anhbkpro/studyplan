select firstName, lastName, city, state
from person
left join address
using (personId)
