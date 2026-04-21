--5. Qual o tempo médio de entrega por região?--
SELECT
	ocd.customer_state ,
	ROUND(avg(julianday(ood.order_delivered_customer_date) - julianday(ood.order_approved_at)),0) AS media_dias_entrega_pos_aprovacao,
	ROUND(avg(julianday(ood.order_delivered_customer_date) - julianday(ood.order_delivered_carrier_date)),0) media_dias_apos_postagem
FROM
	olist_orders_dataset ood
LEFT JOIN olist_customers_dataset ocd on
	ocd.customer_id = ood.customer_id
where
	ood.order_status = 'delivered'
  AND ood.order_delivered_customer_date IS NOT NULL
  AND ood.order_approved_at IS NOT NULL
GROUP BY
	OCD.customer_state
ORDER BY
	media_dias_entrega_pos_aprovacao DESC