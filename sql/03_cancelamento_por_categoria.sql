--3. Qual a taxa de cancelamento por categoria?--
SELECT
    opd.product_category_name,
    COUNT(DISTINCT CASE WHEN ood.order_status = 'canceled' THEN ood.order_id END) AS pedidos_cancelados,
    COUNT(DISTINCT ood.order_id) AS total_pedidos,
    ROUND((COUNT(DISTINCT CASE WHEN ood.order_status = 'canceled' THEN ood.order_id END) * 100.0 / 
     COUNT(DISTINCT ood.order_id)),2) AS taxa_cancelamento_perc
FROM
    olist_orders_dataset ood
JOIN 
    olist_order_items_dataset ooid ON ood.order_id = ooid.order_id
JOIN 
    olist_products_dataset opd ON ooid.product_id = opd.product_id
WHERE 
    opd.product_category_name IS NOT NULL
GROUP BY 
    1
ORDER BY 
    taxa_cancelamento_perc DESC;
