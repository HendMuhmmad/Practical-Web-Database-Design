# Below are some Queries and the techniques used to enhance its performance

### 1. A SQL Query to Retrieve the total number of products in each category.

```mysql
explain analyze select CATEGORY_ID , count(PRODUCT_ID) as TOTAL_PRODUCTS_NUMBER from product_category pc group by CATEGORY_ID 
```

- Output
```
-> Table scan on <temporary>  (actual time=70.2..70.2 rows=100 loops=1)
  -> Aggregate using temporary table  (actual time=70.2..70.2 rows=100 loops=1)
    -> Table scan on pc  (cost=9817 rows=97604) (actual time=0.0212..50.1 rows=100000 loops=1)
```

- Optimization Technique

```mysql
ALTER TABLE product_category ADD INDEX IDX_CAT_PROD_ID (CATEGORY_ID,PRODUCT_ID);
```

- Output

```
-> Group aggregate: count(pc.PRODUCT_ID)  (cost=20149 rows=95) (actual time=0.3..24.9 rows=100 loops=1)
    -> Covering index scan on pc using PRIMARY  (cost=10103 rows=100464) (actual time=0.0382..21.1 rows=100000 loops=1)
```

### 2. A SQL Query to Find the top customers by total spending.

```mysql
explain analyze select CUSTOMER_ID,CONCAT(c.FIRST_NAME,' ', c.LAST_NAME) as CUSTOMER_NAME, sum(TOTAL_COST) as TOTAL_SPENDING
from orders o
inner join customer c on c.ID = o.CUSTOMER_ID
group by CUSTOMER_ID  order by TOTAL_SPENDING desc
```

- Output
  
```
-> Sort: TOTAL_SPENDING DESC  (actual time=147499..147552 rows=811534 loops=1)
    -> Table scan on <temporary>  (actual time=146308..146782 rows=811534 loops=1)
        -> Aggregate using temporary table  (actual time=146307..146307 rows=811533 loops=1)
            -> Nested loop inner join  (cost=1.48e+6 rows=2.25e+6) (actual time=2.99..133894 rows=2e+6 loops=1)
                -> Table scan on c  (cost=100963 rows=953568) (actual time=1.94..4039 rows=1e+6 loops=1)
                -> Index lookup on o using CUSTOMER_ID (CUSTOMER_ID=c.ID)  (cost=1.21 rows=2.36) (actual time=0.119..0.129 rows=2 loops=1e+6)
```

- Optimization Technique

```mysql
ALTER TABLE orders ADD INDEX INDEX_CUSTOMER_ID_TOTAL_COST (CUSTOMER_ID, TOTAL_COST);

explain analyze select CUSTOMER_ID,CONCAT(c.FIRST_NAME,' ', c.LAST_NAME) as CUSTOMER_NAME, TOTAL_SPENDING
from (select CUSTOMER_ID, sum(TOTAL_COST) as TOTAL_SPENDING from orders o group by CUSTOMER_ID order by TOTAL_SPENDING desc) o
inner join customer c on c.ID = o.CUSTOMER_ID 
```

- Output

```
-> Nested loop inner join  (cost=858719 rows=0) (actual time=2120..7460 rows=811534 loops=1)
    -> Table scan on o  (cost=2.5..2.5 rows=0) (actual time=2046..2138 rows=811534 loops=1)
        -> Materialize  (cost=0..0 rows=0) (actual time=2046..2046 rows=811534 loops=1)
            -> Sort: TOTAL_SPENDING DESC  (actual time=1952..1985 rows=811534 loops=1)
                -> Stream results  (cost=377645 rows=807422) (actual time=0.0669..1383 rows=811534 loops=1)
                    -> Group aggregate: sum(o.TOTAL_COST)  (cost=377645 rows=807422) (actual time=0.0614..1257 rows=811534 loops=1)
                        -> Covering index scan on o using INDEX_CUSTOMER_ID_TOTAL_COST  (cost=192042 rows=1.86e+6) (actual time=0.0542..992 rows=2e+6 loops=1)
    -> Single-row index lookup on c using PRIMARY (ID=o.CUSTOMER_ID)  (cost=0.463 rows=1) (actual time=0.00641..0.00643 rows=1 loops=811534)
```

### 3. A SQL Query to Retrieve the most recent orders with customer information with 1000 orders.

```mysql
explain analyze SELECT o.ID , o.order_date, o.TOTAL_COST ,
c.id, c.first_name, c.last_name, c.email
FROM customer c
JOIN orders o ON o.customer_id = c.ID 
ORDER BY o.order_date DESC
LIMIT 1000;
```

- Output
  
```
-> Limit: 1000 row(s)  (cost=2e+6 rows=1000) (actual time=1705..2227 rows=1000 loops=1)
    -> Nested loop inner join  (cost=2e+6 rows=1.86e+6) (actual time=1705..2226 rows=1000 loops=1)
        -> Sort: o.ORDER_DATE DESC  (cost=190065 rows=1.86e+6) (actual time=1627..1628 rows=1000 loops=1)
            -> Table scan on o  (cost=190065 rows=1.86e+6) (actual time=25.8..999 rows=2e+6 loops=1)
        -> Single-row index lookup on c using PRIMARY (ID=o.CUSTOMER_ID)  (cost=0.873 rows=1) (actual time=0.597..0.597 rows=1 loops=1000)
```

- Optimization Technique

```mysql
ALTER TABLE orders ADD INDEX INDEX_ORDER_DATE(ORDER_DATE);
```

- Output

```
-> Limit: 1000 row(s)  (cost=1.62e+6 rows=1000) (actual time=0.378..6.67 rows=1000 loops=1)
    -> Nested loop inner join  (cost=1.62e+6 rows=1000) (actual time=0.378..6.62 rows=1000 loops=1)
        -> Index scan on o using INDEX_ORDER_DATE (reverse)  (cost=2.24 rows=1000) (actual time=0.363..3.12 rows=1000 loops=1)
        -> Single-row index lookup on c using PRIMARY (ID=o.CUSTOMER_ID)  (cost=0.873 rows=1) (actual time=0.00337..0.00339 rows=1 loops=1000)
```

### 4. A SQL Query to List products that have low stock quantities of less than 60 quantities.

```mysql
explain analyze select p.NAME  from product p where p.QUANTITY < 60
```

- Output
  
```
-> Filter: (p.QUANTITY < 60)  (cost=10241 rows=32930) (actual time=0.0567..36.7 rows=20039 loops=1)
    -> Table scan on p  (cost=10241 rows=98799) (actual time=0.0527..32.2 rows=100000 loops=1)
```

- Optimization Technique

```mysql
ALTER TABLE product ADD INDEX INDEX_QUANTITY (QUANTITY,NAME);
```

- Output

```
-> Filter: (p.QUANTITY < 60)  (cost=10327 rows=41700) (actual time=0.0262..10.6 rows=20039 loops=1)
    -> Covering index range scan on p using INDEX_QUANTITY over (QUANTITY < 60)  (cost=10327 rows=41700) (actual time=0.0239..8.72 rows=20039 loops=1)
```

### 5. A SQL Query to Calculate the revenue generated from each product category.

```mysql
explain analyze select c.ID ,c.NAME , sum(p.PRICE)
from order_detail od
inner join product p on p.ID = od.PRODUCT_ID 
inner join product_category pc  on pc.PRODUCT_ID = p.ID 
inner join category c on c.ID = pc.CATEGORY_ID 
group by c.id
```

- Output
  
```
-> Table scan on <temporary>  (actual time=8357..8357 rows=100 loops=1)
    -> Aggregate using temporary table  (actual time=8357..8357 rows=100 loops=1)
        -> Nested loop inner join  (cost=807898 rows=5.67e+6) (actual time=0.376..5176 rows=6e+6 loops=1)
            -> Nested loop inner join  (cost=143982 rows=98799) (actual time=0.255..586 rows=100000 loops=1)
                -> Nested loop inner join  (cost=109402 rows=98799) (actual time=0.216..389 rows=100000 loops=1)
                    -> Table scan on p  (cost=10241 rows=98799) (actual time=0.0796..59.7 rows=100000 loops=1)
                    -> Covering index lookup on pc using product_category_ibfk_2 (PRODUCT_ID=p.ID)  (cost=0.904 rows=1) (actual time=0.0026..0.00315 rows=1 loops=100000)
                -> Single-row index lookup on c using PRIMARY (ID=pc.CATEGORY_ID)  (cost=0.25 rows=1) (actual time=0.00181..0.00183 rows=1 loops=100000)
            -> Covering index lookup on od using PRODUCT_ID (PRODUCT_ID=p.ID)  (cost=0.985 rows=57.3) (actual time=0.0349..0.0434 rows=60 loops=100000)
```

- Optimization Technique

```mysql
explain analyze SELECT 
    sh.PRODUCT_DEFAULT_CATEGORY_ID AS ID,
    sh.CATEGORY_NAME AS NAME,
    SUM(sh.PRODUCT_PRICE) AS total_price
FROM 
    sales_history sh 
GROUP BY 
    sh.PRODUCT_DEFAULT_CATEGORY_ID,sh.CATEGORY_NAME;

   
ALTER TABLE sales_history  ADD INDEX INDEX_CATEGORY (PRODUCT_DEFAULT_CATEGORY_ID,CATEGORY_NAME,PRODUCT_PRICE);

```

- Output

```
-> Group aggregate: sum(sh.PRODUCT_PRICE)  (cost=84411 rows=101) (actual time=5280..5410 rows=100 loops=1)
    -> Covering index scan on sh using INDEX_CATEGORY  (cost=44085 rows=6000000) (actual time=0.0521..5280 rows=6000000 loops=1)
```

<br>

## Summary 

| Sample Query | Execution Time Before Optimization | Optimization Technique | Rewritten Query | Execution Time After Optimization |
|--------------|------------------------------------|------------------------|-----------------|-----------------------------------|
| select CATEGORY_ID , count(PRODUCT_ID) as TOTAL_PRODUCTS_NUMBER from product_category pc group by CATEGORY_ID | 70.2 ms | Create a composite index on category id and product id for product_category table | - | 0.3 ms |
| select CUSTOMER_ID,CONCAT(c.FIRST_NAME,' ', c.LAST_NAME) as CUSTOMER_NAME, sum(TOTAL_COST) as TOTAL_SPENDING from orders o inner join customer c on c.ID = o.CUSTOMER_ID group by CUSTOMER_ID  order by TOTAL_SPENDING desc | 147499 ms | Query Rewriting and adding a composite index on cutomer id and total price for orders tables | select CUSTOMER_ID,CONCAT(c.FIRST_NAME,' ', c.LAST_NAME) as CUSTOMER_NAME, TOTAL_SPENDING from (select CUSTOMER_ID, sum(TOTAL_COST) as TOTAL_SPENDING from orders o group by CUSTOMER_ID order by TOTAL_SPENDING desc) o inner join customer c on c.ID = o.CUSTOMER_ID  | 2120 ms |
| SELECT o.ID , o.order_date, o.TOTAL_COST , c.id, c.first_name, c.last_name, c.email FROM customer c JOIN orders o ON o.customer_id = c.ID  ORDER BY o.order_date DESC LIMIT 1000; | 1705 ms | Create an index on order date | - | 0.378 ms |
| select p.NAME  from product p where p.QUANTITY < 60 | 0.0567 ms | Create a composite index on name and quantity | - | 0.0262 ms |
| select c.ID ,c.NAME , sum(p.PRICE) from order_detail od inner join product p on p.ID = od.PRODUCT_ID  inner join product_category pc  on pc.PRODUCT_ID = p.ID  inner join category c on c.ID = pc.CATEGORY_ID  group by c.id | 8357 ms | Using the denormalized table SALES_HISTORY with covering index | - | 5280 ms |

    
