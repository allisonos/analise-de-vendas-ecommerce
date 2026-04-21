--1. Qual categoria de produto gera mais receita por mês?--
--
--CTE retorando vendas agrupado por mês e categoria--
	WITH vendas_por_mes AS (
SELECT
	strftime('%Y-%m', ood.order_purchase_timestamp) AS "ano-mes",
	opd.product_category_name,
	SUM(ooid.price) AS Receita_Bruta,
	COUNT(*) AS qtd
FROM
	olist_order_items_dataset ooid
LEFT JOIN
        olist_orders_dataset ood ON
	ood.order_id = ooid.order_id
LEFT JOIN 
        olist_products_dataset opd ON
	opd.product_id = ooid.product_id
WHERE
	ood.order_status = 'delivered'
	AND opd.product_category_name IS NOT NULL
GROUP BY
	1,
	2
),
--CTE Ranqueando categorias que mais geram receita por mês--
Rank_por_cat AS (
SELECT
	*,
	DENSE_RANK() OVER (PARTITION BY "ano-mes"
ORDER BY
	Receita_Bruta DESC) AS rank
FROM
	vendas_por_mes 
)
--Resultado Final --
SELECT
	"ano-mes",
	product_category_name,
	Receita_Bruta,
	qtd
FROM
	Rank_por_cat
WHERE
	rank = 1
ORDER BY
	"ano-mes";