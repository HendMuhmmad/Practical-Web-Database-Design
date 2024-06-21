# Sample Queries

- A SQL query to generate a daily report of the total revenue for a specific date.
 
```mysql
select sum(eo.TOTAL_COST) as DAILY_REVENUE
from
orders eo
where
date_format(eo.ORDER_DATE, '%Y-%m-%d') = :day_date;
 ```

- A SQL query to generate a monthly report of the top-selling products in a given month.

```mysql
select od.PRODUCT_ID , p.NAME , sum(od.QUANTITY) as TOTAL_SELLING
from orders eo, order_detail od, product p 
where od.ORDER_ID = eo.ID
and od.PRODUCT_ID  = p.ID
and date_format(eo.ORDER_DATE,'%Y-%m') = :month_date 
group by od.PRODUCT_ID
order by TOTAL_SELLING desc;
```

- A SQL query to retrieve a list of customers who have placed orders totaling more than $500 in the past month. 
 Include customer names and their total order amounts

```mysql
select C.ID, concat(c.FIRST_NAME,' ',c.LAST_NAME) as CUSTOMER_NAME, sum(EO.TOTAL_COST) as TOTAL_ORDERS_COST 
from orders eo , customer c 
where eo.CUSTOMER_ID = c.ID and YEAR(eo.ORDER_DATE) = YEAR(CURDATE() - INTERVAL 1 MONTH) and MONTH(eo.ORDER_DATE) = MONTH(CURDATE() - INTERVAL 1 MONTH)
group by c.ID 
having sum(eo.TOTAL_COST) > 500;
```

- A SQL query to search for all products with the word "camera" in either the product name or description.

```mysql
select p.NAME ,p.SHORT_DESCRIPTION ,p.LONG_DESCRIPTION 
from product p 
where lower(p.SHORT_DESCRIPTION) like '%camera%'
or lower(p.LONG_DESCRIPTION) like '%camera%'
or lower(p.NAME) like '%camera%';
```

-  A SQL query to suggest popular products in the same category excluding the Purchsed product from the recommendations.

```mysql
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
```

- A trigger to Create a sale history [Above customer , product], when a new order is made in the "Orders" table,
 automatically generates a sale history record for that order, capturing details such as the order date, customer, product, 
 , total amount, and quantity. The trigger should be triggered on Order insertion.

```mysql
CREATE TABLE SALES_HISTORY(
    ID INTEGER AUTO_INCREMENT,
	CUSTOMER_ID INTEGER NOT NULL,
	CUSTOMER_FIRST_NAME VARCHAR(50), 
	CUSTOMER_LAST_NAME VARCHAR(50),
	CUSTOMER_EMAIL VARCHAR(100) NOT NULL,
	ORDER_ID INTEGER,
	ORDER_DATE DATETIME NOT NULL,
	ORDER_SHIP_DATE DATETIME NOT NULL,
	ORDER_TOTAL_COST DECIMAL(7,2) NOT NULL,
	ORDER_SHIPPING_COST DECIMAL(7,2) NOT NULL,
	PRODUCT_ID INTEGER,
	PRODUCT_DEFAULT_CATEGORY_ID INTEGER NOT NULL,
	CATEGORY_NAME VARCHAR(100),
	PRODUCT_NAME VARCHAR(100) NOT NULL, 
    PRODUCT_SHORT_DESCRIPTION VARCHAR(500),
	PRODUCT_LONG_DESCRIPTION VARCHAR(2000),
	PRODUCT_SIZE VARCHAR(10),
	PRODUCT_COLOR VARCHAR(10),
	PRODUCT_WEIGHT DECIMAL(7.2),
	PRODUCT_PRICE DECIMAL(7,2) NOT NULL,
	PRODUCT_QUANNTITY SMALLINT NOT NULL,
    PRIMARY KEY (ID),
	FOREIGN KEY (CUSTOMER_ID ) REFERENCES CUSTOMER(ID),
	FOREIGN KEY (PRODUCT_ID ) REFERENCES PRODUCT(ID),
	FOREIGN KEY (ORDER_ID ) REFERENCES ORDERS(ID),
	FOREIGN KEY (PRODUCT_DEFAULT_CATEGORY_ID ) REFERENCES CATEGORY(ID)
);

CREATE  TRIGGER SALES_HISORY_TRIGGER  
AFTER INSERT ON ORDER_DETAIL FOR EACH ROW   
INSERT INTO SALES_HISTORY (CUSTOMER_ID,
	CUSTOMER_FIRST_NAME, 
	CUSTOMER_LAST_NAME,
	CUSTOMER_EMAIL,
	ORDER_ID,
	ORDER_DATE,
	ORDER_SHIP_DATE,
	ORDER_TOTAL_COST,
	ORDER_SHIPPING_COST,
	PRODUCT_ID ,
	PRODUCT_DEFAULT_CATEGORY_ID,
	CATEGORY_NAME,
	PRODUCT_NAME, 
    PRODUCT_SHORT_DESCRIPTION,
	PRODUCT_LONG_DESCRIPTION,
	PRODUCT_SIZE,
	PRODUCT_COLOR,
	PRODUCT_WEIGHT,
	PRODUCT_PRICE,
	PRODUCT_QUANNTITY) 
	select C.ID ,C.FIRST_NAME ,C.LAST_NAME ,C.EMAIL ,O.ID ,O.ORDER_DATE ,O.ORDER_SHIP_DATE ,O.TOTAL_COST ,O.SHIPPING_COST ,P.ID ,CA.ID ,CA.NAME,
	P.NAME, P.SHORT_DESCRIPTION , P.LONG_DESCRIPTION , P.`SIZE` ,P.COLOR ,P.WEIGHT ,P.PRICE ,new.QUANTITY
	FROM orders o , order_detail od , customer c ,product p , product_category pc , category ca
	WHERE o.ID = od.ORDER_ID 
	and OD.PRODUCT_ID = P.ID 
	and O.CUSTOMER_ID  = C.ID 
	and PC.PRODUCT_ID = P.ID 
	and PC.CATEGORY_ID = ca.ID 
	and PC.DEFAULT_CATEGORY = 1
	and o.ID = new.ORDER_ID
	and p.ID = new.PRODUCT_ID;
```

- A SQL query to generate a monthly report of the top-selling products in a given month using sales history table.

```mysql
select sh.PRODUCT_ID , sh.PRODUCT_NAME ,sum(sh.PRODUCT_QUANNTITY) as TOTAL_SELLING from sales_history sh 
where date_format(sh.ORDER_DATE,'%Y-%m') = :month_date 
group by sh.PRODUCT_ID, sh.PRODUCT_NAME
order by TOTAL_SELLING desc;
```

-  A SQL query to suggest popular products in the same category excluding the Purchsed product from the recommendations using sales history table.

```mysql
select p.ID, p.NAME, p.SHORT_DESCRIPTION, p.LONG_DESCRIPTION
from
	product p ,
	product_category pc
where
	pc.PRODUCT_ID = p.ID
	and pc.DEFAULT_CATEGORY = 1
	and pc.CATEGORY_ID in (select distinct sh.PRODUCT_DEFAULT_CATEGORY_ID from sales_history sh where sh.CUSTOMER_ID = :CUSTOMER_ID)
	and p.ID not in (select distinct sh.PRODUCT_ID from sales_history sh where sh.CUSTOMER_ID = :CUSTOMER_ID );
```

- A transaction query to lock row with product id = 211 from being updated.

```mysql
START TRANSACTION ;
SELECT * FROM product p  WHERE P.ID  = 211 FOR UPDATE;
COMMIT;
```
