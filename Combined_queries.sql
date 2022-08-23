SELECT
	o.order_id,
    i.item_price,
    o.quantity,
    i.item_cat,
    i.item_name,
    o.created_at,
    a.delivery_address1,
    a.delivery_address2,
    a.delivery_city,
    a.delivery_zipCode,
    o.delivery
FROM
	orders o
    LEFT JOIN item i ON o.item_id = i.item_id
    LEFT JOIN address a ON o.add_id = a.add_id
;



SELECT
s1.item_name,
s1.ing_id,
s1.ing_name,
s1.ing_weight,
s1.ing_price,
s1.order_quantity,
s1.recipe_quantity,
s1.order_quantity*s1.recipe_quantity as ordered_weight,
s1.ing_price/s1.ing_weight as unit_cost,
(s1.order_quantity*s1.recipe_quantity)*(s1.ing_price/s1.ing_weight) as ingredient_cost
FROM (SELECT
	o.item_id,
	i.sku,
    i.item_name,
    r.ing_id,
    r.quantity AS recipe_quantity,
    SUM(o.quantity) AS order_quantity,
    ing.ing_weight,
    ing.ing_price
FROM
	orders o
    LEFT JOIN item i ON o.item_id = i.item_id
    LEFT JOIN recipe r ON i.sku =  r.recipe_id
GROUP BY 
	o.item_id,
    i.sku,
    i.item_name,
    r.ing_id,
    r.quantity,
    ing.ing_weight,
    ingt.ing_price
) s1
;

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

SELECT 
	r.date,
    s.firstNAme,
    s.lastName,
    s.houry_rate,
    sh.start_time,
    sh.end_time
    ((hour(timediff(sh.end_time,sh.start_time))*60)+(minute(timediff(sh.end_time, sh.start_time))))/60 as hours_in_shift,
	((hour(timediff(sh.end_time,sh.start_time))*60)+(minute(timediff(sh.end_time, sh.start_time))))/60 *s.houry_rate as staff_cost
FROM rotation r
LEFT JOIN  staff s ON r.staff_id = s.staff_id
LEFT JOIN  shift sh ON r.shift_id = sh.shift_i
;
    
    
    
    
    
    
    