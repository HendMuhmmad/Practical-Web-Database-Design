CREATE PROCEDURE InsertRandomCustomers()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE batch_size INT DEFAULT 10000; 
    DECLARE total_rows INT DEFAULT 1000000; 
    DECLARE first_name_list VARCHAR(1000);
    DECLARE last_name_list VARCHAR(1000);
    DECLARE email_list VARCHAR(1000);
    DECLARE username_list VARCHAR(1000);
    DECLARE password_list VARCHAR(1000);
    DECLARE street_list VARCHAR(1000);
    DECLARE building_list VARCHAR(1000);
    DECLARE floor_list VARCHAR(1000);
    DECLARE apartment_list VARCHAR(1000);
    DECLARE city_list VARCHAR(1000);
    DECLARE country_list VARCHAR(1000);
    DECLARE postal_code_list VARCHAR(1000);
    DECLARE first_name VARCHAR(50);
    DECLARE last_name VARCHAR(50);
    DECLARE email VARCHAR(100);
    DECLARE username VARCHAR(20);
    DECLARE passwordd VARCHAR(20);
    DECLARE street VARCHAR(100);
    DECLARE building VARCHAR(10);
    DECLARE floor_val VARCHAR(10);
    DECLARE apartment_val VARCHAR(10);
    DECLARE city VARCHAR(100);
    DECLARE country VARCHAR(100);
    DECLARE postal_code VARCHAR(10);
    DECLARE comments VARCHAR(1000);
    
  	SET first_name_list = 'John,Mary,Robert,Linda,Michael,Barbara,William,Elizabeth,David,Jennifer,Richard,Susan,Joseph,Margaret,Charles,Dorothy,Thomas,Lisa,Christopher,Nancy,Daniel,Betty,Matthew,Helen,Anthony,Sandra,Donald,Ashley,Mark,Kimberly,Paul,Donna,Steven,Emily,Andrew,Carol,Kenneth,Michelle,Joshua,Amanda,George,Melissa,Edward,Deborah,Brian,Stephanie,Ronald,Laura';
    
    SET last_name_list = 'Smith,Johnson,Williams,Jones,Brown,Davis,Miller,Wilson,Moore,Taylor,Anderson,Thomas,Jackson,White,Harris,Martin,Thompson,Garcia,Martinez,Robinson,Clark,Rodriguez,Lewis,Lee,Walker,Hall,Allen,Young,Hernandez,King,Wright,Lopez,Hill,Scott,Green,Adams,Baker,Gonzalez,Nelson,Carter,Mitchell,Perez,Roberts,Turner,Phillips,Campbell,Parker,Evans,Edwards,Collins,Stewart';
    
    SET email_list = 'john.smith@example.com,mary.johnson@example.com,robert.williams@example.com,linda.jones@example.com,michael.brown@example.com,barbara.davis@example.com,william.miller@example.com,elizabeth.wilson@example.com,david.moore@example.com,jennifer.taylor@example.com,richard.anderson@example.com,susan.thomas@example.com,joseph.jackson@example.com,margaret.white@example.com,charles.harris@example.com,dorothy.martin@example.com,thomas.thompson@example.com,lisa.garcia@example.com,christopher.martinez@example.com,nancy.robinson@example.com';
    
	SET username_list = 'johnsmith,maryjohnson,robertwilliams,lindajones,michaelbrown,barbaradavis,williammiller,elizabethwilson,davidmoore,jennifertaylor,richardanderson,susanthomas,josephjackson,margaretwhite,charlesharris,dorothymartin,thomasthompson,lisagarcia,christophermartinez,nancyrobinson,danielclark,bettyrodriguez,matthewlewis,helenee,anthonymiller,sandragonzalez,donaldnelson,ashleyperez,markroberts,kimberlyturner,paulphillips,donnacampbell,stevenparker,georgewalker,ameliahill,benjaminking,oliviawright,edwardlopez,victoriahill,ryanadams,lilybaker,jamesgonzalez,emmaolson,alexandernelson,sophiacarter,ethanmitchell,emilyperez,davidroberts,lauraturner,chloephillips,seanmiller';
    
    SET password_list = 'password1,password2,password3,password4,password5,password6,password7,password8,password9,password10';
        
    SET street_list = 'Main Street,First Avenue,Elm Street,Maple Avenue,Oak Street,Cedar Avenue,Pine Street,Walnut Avenue,High Street,Washington Avenue,Market Street,Church Avenue,Spring Street,Union Avenue,Water Street,Center Avenue,Front Street,Park Avenue,Mill Street,Lake Avenue';
    
    SET building_list = '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15';
    
    SET floor_list = '1,2,3,4,5';
    
    SET apartment_list = 'A,B,C,D,E,F,G,H,I,J,K,L';
    
    SET city_list = 'New York,Los Angeles,Chicago,Houston,Phoenix,Philadelphia,San Antonio,San Diego,Dallas,San Jose,Austin,Jacksonville,San Francisco,Indianapolis,Columbus,Fort Worth,Charlotte,Seattle,Denver,Washington';
    
    SET country_list = 'USA,Canada,Mexico,Brazil,Argentina,UK,Germany,France,Italy,Spain,Japan,China,Australia,India,South Africa,Russia,South Korea,Netherlands,Sweden,Switzerland';
    
    SET postal_code_list = '10001,90001,60601,77001,85001,19101,78201,92101,75201,95101,78701,32201,94101,46201,43201,76101,28201,98101,80201,20001';
    

    WHILE counter <= total_rows DO
        SET @customer_insert = 'INSERT INTO CUSTOMER (FIRST_NAME, LAST_NAME, EMAIL, PASSWORD, USERNAME) VALUES ';
        SET @address_insert = 'INSERT INTO CUSTOMER_ADDRESS (CUSTOMER_ID, STREET, BUILDING, FLOOR, APARTMENT, CITY, COUNTRY, POSTAL_CODE, COMMENTS) VALUES ';
        
        SET @customer_values = '';
        SET @address_values = '';
        
        SET @batch_end = LEAST(counter + batch_size - 1, total_rows);
        
        WHILE counter <= @batch_end DO
            SET first_name = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(first_name_list, ',', (counter-1) % 50 + 1), ',', -1));
            SET last_name = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(last_name_list, ',', (counter-1) % 50 + 1), ',', -1));
            SET email = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(email_list, ',', (counter-1) %50 + 1), ',', -1));
            SET username = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(username_list, ',', (counter-1) % 50 + 1), ',', -1));
            SET passwordd = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(password_list, ',', 1 + RAND() * 10), ',', -1)); -- Random password from list
            SET street = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(street_list, ',', 1 + RAND() * 20), ',', -1)); -- Random street from list
            SET building = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(building_list, ',', 1 + RAND() * 15), ',', -1)); -- Random building number from list
            SET floor_val = IF(RAND() < 0.5, NULL, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(floor_list, ',', 1 + RAND() * 5), ',', -1))); -- Random floor from list, sometimes NULL
            SET apartment_val = IF(RAND() < 0.5, NULL, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(apartment_list, ',', 1 + RAND() * 12), ',', -1))); -- Random apartment from list, sometimes NULL
            SET city = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(city_list, ',', 1 + RAND() * 20), ',', -1)); -- Random city from list
            SET country = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(country_list, ',', 1 + RAND() * 20), ',', -1)); -- Random country from list
            SET postal_code = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(postal_code_list, ',', 1 + RAND() * 20), ',', -1)); -- Random postal code from list
            
            SET @customer_values = CONCAT(@customer_values, '(', QUOTE(first_name), ',', QUOTE(last_name), ',', QUOTE(email), ',', QUOTE(passwordd), ',', QUOTE(username), '),');
            SET @address_values = CONCAT(@address_values, '(',QUOTE(counter),',', QUOTE(street), ',', QUOTE(building), ',', IFNULL(QUOTE(floor_val), 'NULL'), ',', IFNULL(QUOTE(apartment_val), 'NULL'), ',', QUOTE(city), ',', QUOTE(country), ',', QUOTE(postal_code), ',', QUOTE(CONCAT('Address for customer ',counter)), '),');
            
            SET counter = counter + 1;
        END WHILE;
        
        SET @customer_insert = CONCAT(@customer_insert, LEFT(@customer_values, LENGTH(@customer_values) - 1));
        PREPARE stmt1 FROM @customer_insert;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
        
        SET @address_insert = CONCAT(@address_insert, LEFT(@address_values, LENGTH(@address_values) - 1));
        PREPARE stmt2 FROM @address_insert;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        
        COMMIT;
    END WHILE;

    COMMIT;
    
    SELECT 'Data insertion completed.' AS Result;
END;



CALL InsertRandomCustomers();

