CREATE PROCEDURE InsertRandomOrders()
BEGIN
    DECLARE counter INT DEFAULT 1;
   	DECLARE batch_size INT DEFAULT 20000; 
    DECLARE total_rows INT DEFAULT 2000000; 
    DECLARE customer_id INT;
    DECLARE total_cost DECIMAL(7,2);
    DECLARE taxes DECIMAL(7,2);
    DECLARE discount DECIMAL(7,2);
    DECLARE shipping_cost DECIMAL(7,2);
    DECLARE order_date DATETIME;
    DECLARE order_ship_date DATETIME;
    DECLARE product_id INT DEFAULT 1;
    DECLARE quantity SMALLINT;
	DECLARE order_detail_counter INT DEFAULT 1;



    WHILE counter <= total_rows DO
    
    	SET @orders_insert = 'INSERT INTO ORDERS (CUSTOMER_ID, TOTAL_COST, TAXES, DISCOUNT, SHIPPING_COST, ORDER_DATE, ORDER_SHIP_DATE) VALUES ';
    	SET @orders_values = '';
    	SET @order_detail_insert = 'INSERT INTO ORDER_DETAIL (ORDER_ID, PRODUCT_ID, QUANTITY) VALUES ';
        SET @order_detail_values = '';
		SET @batch_end = LEAST(counter + batch_size - 1, total_rows);
		WHILE counter <= @batch_end DO
	        SET customer_id = FLOOR(1 + RAND() * 1000000); 
	        SET total_cost = ROUND(RAND() * 1000 + 100, 2); 
	        SET taxes = ROUND(total_cost * 0.1, 2); 
	        SET discount = ROUND(RAND() * 50, 2); 
	        SET shipping_cost = ROUND(RAND() * 20 + 5, 2); 
	        SET order_date = NOW() - INTERVAL FLOOR(RAND() * 365) DAY;
	        SET order_ship_date = order_date + INTERVAL FLOOR(RAND() * 10) DAY; 
			SET @orders_values = CONCAT(@orders_values, '(', QUOTE(customer_id), ',', QUOTE(total_cost), ',', QUOTE(taxes), ',', QUOTE(discount), ',', QUOTE(shipping_cost), ',', QUOTE(order_date), ',', QUOTE(order_ship_date), '),');
	        SET order_detail_counter = 1;
			WHILE order_detail_counter <= 3 DO
		        SET quantity = FLOOR(RAND() * 10 + 1);
	        	SET @order_detail_values = CONCAT(@order_detail_values, '(',QUOTE(counter),',', QUOTE(product_id), ',', QUOTE(quantity), '),');
	        	SET order_detail_counter = order_detail_counter + 1;
	        	SET product_id = product_id + 1;
	        	IF product_id > 100000 then
	        		SET product_id = 1;
	        	END IF;
			END WHILE;
	        SET counter = counter + 1;
       END WHILE;
        SET @orders_insert = CONCAT(@orders_insert, LEFT(@orders_values, LENGTH(@orders_values) - 1));
        PREPARE stmt1 FROM @orders_insert;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
       
       	SET @order_detail_insert = CONCAT(@order_detail_insert, LEFT(@order_detail_values, LENGTH(@order_detail_values) - 1));
        PREPARE stmt2 FROM @order_detail_insert;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;

        COMMIT;
    END WHILE;

    COMMIT;

    SELECT 'Orders insertion completed.' AS Result;
END;

CALL InsertRandomOrders(); 
