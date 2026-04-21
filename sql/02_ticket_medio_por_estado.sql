--2. Quais estados têm o maior ticket médio?--
SELECT
	ocd.customer_state,
	ROUND((SUM(ooid.price + ooid.freight_value) / COUNT(DISTINCT ood.order_id)), 2) AS ticket_medio
FROM
	olist_order_items_dataset ooid
LEFT JOIN olist_orders_dataset ood ON
	ood.order_id = ooid.order_id
LEFT JOIN olist_customers_dataset ocd ON
	ocd.customer_id = ood.customer_id
WHERE
	ood.order_status = 'delivered'
GROUP BY
	1
ORDER BY
	ticket_medio DESC
LIMIT 10;