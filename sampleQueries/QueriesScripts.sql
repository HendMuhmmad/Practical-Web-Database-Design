select sum(eo.TOTAL_COST) as DAILY_REVENUE
from
	orders eo
where
	date_format(eo.ORDER_DATE, '%Y-%m-%d') = :day_date;
-- 
select od.PRODUCT_ID , p.NAME , sum(od.QUANTITY) as TOTAL_SELLING
from orders eo, order_detail od, product p 
where od.ORDER_ID = eo.ID
and od.PRODUCT_ID  = p.ID
and date_format(eo.ORDER_DATE,'%Y-%m') = :month_date 
group by od.PRODUCT_ID
order by TOTAL_SELLING desc;

select sh.PRODUCT_ID , sh.PRODUCT_NAME ,sum(sh.PRODUCT_QUANNTITY) as TOTAL_SELLING from sales_history sh 
where date_format(sh.ORDER_DATE,'%Y-%m') = :month_date 
group by sh.PRODUCT_ID, sh.PRODUCT_NAME
order by TOTAL_SELLING desc;
-- 
select C.ID, concat(c.FIRST_NAME,' ',c.LAST_NAME) as CUSTOMER_NAME, sum(EO.TOTAL_COST) as TOTAL_ORDERS_COST 
from orders eo , customer c 
where eo.CUSTOMER_ID = c.ID and YEAR(eo.ORDER_DATE) = YEAR(CURDATE() - INTERVAL 1 MONTH) and MONTH(eo.ORDER_DATE) = MONTH(CURDATE() - INTERVAL 1 MONTH)
group by c.ID 
having sum(eo.TOTAL_COST) > 500;
-- 
select p.NAME ,p.SHORT_DESCRIPTION ,p.LONG_DESCRIPTION 
from product p 
where lower(p.SHORT_DESCRIPTION) like '%camera%'
or lower(p.LONG_DESCRIPTION) like '%camera%'
or lower(p.NAME) like '%camera%';
-- 
with customer_products as (select p.ID  , pc.CATEGORY_ID
from orders eo , order_detail od , product p, product_category pc , customer c 
where  c.ID = eo.CUSTOMER_ID 
and pc.PRODUCT_ID = p.ID
and pc.DEFAULT_CATEGORY = 1
and c.ID = :CUSTOMER_ID
and eo.ID = od.ORDER_ID
and od.PRODUCT_ID = p.ID
group by p.ID, pc.CATEGORY_ID
order by sum(od.QUANTITY) desc)

select p.ID, p.NAME, p.SHORT_DESCRIPTION,  p.LONG_DESCRIPTION
from
	product p ,
	product_category pc
where
	pc.PRODUCT_ID = p.ID
and pc.DEFAULT_CATEGORY = 1
and pc.CATEGORY_ID in (select cp.CATEGORY_ID from customer_products cp )
and p.ID not in (select cp.ID from customer_products cp );

select p.ID, p.NAME, p.SHORT_DESCRIPTION, p.LONG_DESCRIPTION
from
	product p ,
	product_category pc
where
	pc.PRODUCT_ID = p.ID
	and pc.DEFAULT_CATEGORY = 1
	and pc.CATEGORY_ID in (select distinct sh.PRODUCT_DEFAULT_CATEGORY_ID from sales_history sh where sh.CUSTOMER_ID = :CUSTOMER_ID)
	and p.ID not in (select distinct sh.PRODUCT_ID from sales_history sh where sh.CUSTOMER_ID = :CUSTOMER_ID );
-- 
START TRANSACTION ;
SELECT * FROM product p  WHERE P.ID  = 211 FOR UPDATE;
COMMIT;


START TRANSACTION ;
SELECT p.QUANNTITY  FROM product p  WHERE P.ID  = 211 FOR UPDATE;