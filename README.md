# **PROJECT BRIEF**
The client is opening up a new pizza restraunt in his town, it won't be a dine in but rather just a take-out and delivery like Domino's. 
Our client has given us a project brief, the first part requires us to to design and build a tailor-made relational database for his business that will allow him to capture and store all the important information and data that the business genarates.
This will in turn help our client monitor business perfomance in dashboards.
There are three main areas that the brief requires us to concentrate on.

* Customer Orders
* Stock/Invertory Control
* Staff Management



  
## SYSTEM ARCHITECTURE DESIGN - ER-DIAGRAM
Use <https://app.quickdatabasediagrams.com/#/> to design your ER-diagram
![System Design](https://user-images.githubusercontent.com/69304233/185984924-f15e0c27-8924-4b2b-8c54-026373dd2ab9.png)



## ORDER QUERIES
For this queries, we need to write custom queries for our view table to diplay data needed for dashboarding. The following includes:
  * Total orders
  * Total sales
  * Total items
  * Average order value
  * Sales by category
  * Top selling items
  * Orders by hour
  * Sales by hour
  * Order by address
  * Orders by delivery/pickup
  
  ```
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

  ```


## STOCK MANAGEMENT QUERIES
We need to calculate how much stock/invertory we are using and identify the invertory that need reodering/restocking. 
We also want to calculate how much each pizza costs to make based on the cost of the ingredient so we can keep an eye on pricing and profit/loss.
Here is what we need:
  * Total quantity by ingredient
  * Total cost of ingredients
  * Calculated cost of pizza
  * Percentage stock remaing by ingredient
  
  ```
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

  ```
  
  
  ```
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
  ```
  
## STAFF QUERIES
With this custom queries, wwe want to produce view table for the working staff members.
The queries will produce name of the staff working at a given time, Their hourly rate, shift period etc

```
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
```


:tada: :fireworks: 

:tada: :fireworks:
