SELECT 
	s2.ing_name,
    s2.ordered_weight,
    ing.ing_weight*inv.quantity as total_inv_weight,
    (ing.ing_weignt * inv.quantity)-s2.ordered_weight as remaining_weight
FROM (SELECT
		ing_id,
		ing_name,
		SUM(ordered_weight) as orderd_weight
FROM
	stock1_query
    group by ing_name, ing_id) s2
LEFT JOIN invertory inv ON inv.item_id = s2.ing_id
LEFT JOIN ingredient ing ON ing.ing_id = s2.ing_id
;