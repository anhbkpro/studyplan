select ROUND(SUM(item_count * order_occurrences) / SUM(order_occurrences), 2) as average_items_per_order
from orders
