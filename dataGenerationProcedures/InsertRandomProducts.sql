
CREATE PROCEDURE InsertRandomProducts()
begin
	DECLARE batch_size INT DEFAULT 1000; 
    DECLARE total_rows INT DEFAULT 100000;
    DECLARE counter INT DEFAULT 1;
    DECLARE product_name VARCHAR(100);
    DECLARE short_description VARCHAR(500);
    DECLARE long_description VARCHAR(2000);
    DECLARE size VARCHAR(50);
    DECLARE color VARCHAR(10);
    DECLARE weight DECIMAL(7,2);
    DECLARE price DECIMAL(7,2);
    DECLARE quantity SMALLINT;
    DECLARE picture VARCHAR(100);
    DECLARE discounts DECIMAL(7,2);
    DECLARE shipping_cost DECIMAL(7,2);
    DECLARE is_available DECIMAL(1,0);
    DECLARE category_id INT;


    WHILE counter <= total_rows DO
        SET @product_insert = 'INSERT INTO PRODUCT (NAME, SHORT_DESCRIPTION, LONG_DESCRIPTION, SIZE, COLOR, WEIGHT, PRICE, QUANTITY, PICTURE, DISCOUNTS, SHIPPING_COST, IS_AVAILABLE) VALUES ';
        SET @product_categroy_insert = 'INSERT INTO PRODUCT_CATEGORY (CATEGORY_ID, PRODUCT_ID, DEFAULT_CATEGORY) VALUES ';
        
        SET @product_values = '';
        SET @product_categroy_values = '';
        
        SET @batch_end = LEAST(counter + batch_size - 1, total_rows);
       
        WHILE counter <= @batch_end DO
	        SET category_id = FLOOR(1 + RAND() * 100);
	
	        CASE category_id
	            WHEN 1 THEN -- Electronics
	                SET product_name = CONCAT('Electronics Product ', counter);
	                SET short_description = 'High-quality electronics product';
	                SET long_description = 'This electronics product provides excellent features and performance.';             
	                SET picture = CONCAT('https://example.com/electronics/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 2 THEN -- Clothing
	                SET product_name = CONCAT('Clothing Product ', counter);
	                SET short_description = 'Stylish clothing item';
	                SET long_description = 'This clothing product offers comfort and style.';
					SET size = CASE FLOOR(RAND() * 5)
	                                WHEN 0 THEN 'XS'
	                                WHEN 1 THEN 'S'
	                                WHEN 2 THEN 'M'
	                                WHEN 3 THEN 'L'
	                                WHEN 4 THEN 'XL'
	                            END;  
	               SET picture = CONCAT('https://example.com/clothing/', counter, '.jpg'); -- Example picture URL
	
	            WHEN 3 THEN -- Home Appliances
	                    SET product_name = CONCAT('Home Appliance ', counter);
	                    SET short_description = 'Efficient home appliance';
	                    SET long_description = 'This home appliance makes your life easier.';
	                    SET size = ''; -- Size varies greatly, specific to each appliance                    
	                    SET picture = CONCAT('https://example.com/home-appliances/', counter, '.jpg'); -- Example picture URL
	            WHEN 4 THEN -- Books
	                SET product_name = CONCAT('Book ', counter);
	                SET short_description = 'Engaging book';
	                SET long_description = 'This book is a must-read for every book lover.';
	                SET size = CONCAT(ROUND(RAND() * 10 + 10, 1), ' x ', ROUND(RAND() * 10 + 15, 1), ' cm'); -- Random size like 15 x 20 cm
	                SET picture = CONCAT('https://example.com/books/', counter, '.jpg'); -- Example picture URL
	                
	
	            WHEN 5 THEN -- Sports Equipment
	                SET product_name = CONCAT('Sports Equipment ', counter);
	                SET short_description = 'High-performance sports equipment';
	                SET long_description = 'This sports equipment enhances your athletic performance.';
	                SET size = CONCAT(ROUND(RAND() * 50 + 100), ' cm'); -- Random size between 100 and 150 cm
	                
	            WHEN 6 THEN -- Beauty Products
	                SET product_name = CONCAT('Beauty Product ', counter);
	                SET short_description = 'Effective beauty product';
	                SET long_description = 'This beauty product enhances your natural beauty.';
	                SET size = CONCAT(ROUND(RAND() * 5 + 5, 1), ' ml'); -- Random size between 5 and 10 ml
	                SET picture = CONCAT('https://example.com/beauty/', counter, '.jpg'); -- Example picture URL
	            
	           WHEN 7 THEN -- Toys
	                SET product_name = CONCAT('Toy ', counter);
	                SET short_description = 'Fun and educational toy';
	                SET long_description = 'This toy brings joy and learning to children.';
	                SET size = CONCAT(ROUND(RAND() * 20 + 10, 1), ' cm'); -- Random size between 10 and 30 cm
	                SET picture = CONCAT('https://example.com/toys/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 8 THEN -- Furniture
	                SET product_name = CONCAT('Furniture ', counter);
	                SET short_description = 'Stylish furniture piece';
	                SET long_description = 'This furniture piece enhances your living space.';
	                SET size = CONCAT(ROUND(RAND() * 100 + 50), ' x ', ROUND(RAND() * 50 + 50), ' cm'); -- Random size like 100 x 100 cm
	                SET picture = CONCAT('https://example.com/furniture/', counter, '.jpg'); -- Example picture URL
	                
	
	            WHEN 9 THEN -- Automotive Parts
	                SET product_name = CONCAT('Automotive Part ', counter);
	                SET short_description = 'Essential automotive part';
	                SET long_description = 'This automotive part ensures smooth operation of your vehicle.';
	                SET size = CONCAT(ROUND(RAND() * 50 + 20), ' cm'); -- Random size between 20 and 70 cm
	                SET picture = CONCAT('https://example.com/automotive/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 10 THEN -- Outdoor Gear
	                SET product_name = CONCAT('Outdoor Gear ', counter);
	                SET short_description = 'Durable outdoor gear';
	                SET long_description = 'This outdoor gear withstands the elements for your adventures.';
	                SET size = CONCAT(ROUND(RAND() * 50 + 50), ' cm'); -- Random size between 50 and 100 cm
	                SET picture = CONCAT('https://example.com/outdoor/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 11 THEN -- Kitchenware
	                SET product_name = CONCAT('Kitchenware ', counter);
	                SET short_description = 'Quality kitchenware';
	                SET long_description = 'This kitchenware enhances your cooking experience.';
	                SET picture = CONCAT('https://example.com/kitchenware/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 12 THEN -- Pet Supplies
	                SET product_name = CONCAT('Pet Supply ', counter);
	                SET short_description = 'Essential pet supply';
	                SET long_description = 'This pet supply ensures the well-being of your pet.';
	                SET size = CONCAT(ROUND(RAND() * 50 + 20), ' cm'); -- Random size between 20 and 70 cm
	                SET picture = CONCAT('https://example.com/pet/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 13 THEN -- Health Supplements
	                SET product_name = CONCAT('Health Supplement ', counter);
	                SET short_description = 'Effective health supplement';
	                SET long_description = 'This health supplement supports your well-being.';
	                SET size = CONCAT(ROUND(RAND() * 5 + 5, 1), ' ml'); -- Random size between 5 and 10 ml
	                SET picture = CONCAT('https://example.com/supplements/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 14 THEN -- Jewelry
	                SET product_name = CONCAT('Jewelry Item ', counter);
	                SET short_description = 'Elegant jewelry item';
	                SET long_description = 'This jewelry item enhances your elegance.';
	                SET size = ''; -- Size varies greatly, can be specific to each item
	                SET picture = CONCAT('https://example.com/jewelry/', counter, '.jpg'); -- Example picture URL
	               
	            WHEN 15 THEN -- Musical Instruments
	                SET product_name = CONCAT('Musical Instrument ', counter);
	                SET short_description = 'High-quality musical instrument';
	                SET long_description = 'This musical instrument enriches your musical experience.';
	                SET size = CONCAT(ROUND(RAND() * 100 + 50), ' cm'); -- Random size between 50 and 150 cm
	                SET picture = CONCAT('https://example.com/instruments/', counter, '.jpg'); -- Example picture URL
	            WHEN 16 THEN -- Office Supplies
	                SET product_name = CONCAT('Office Supply ', counter);
	                SET short_description = 'Essential office supply';
	                SET long_description = 'This office supply enhances your productivity.';
	                SET size = CONCAT(ROUND(RAND() * 30 + 10), ' cm'); -- Random size between 10 and 40 cm
	            WHEN 17 THEN -- Gardening Tools
				    SET product_name = CONCAT('Gardening Tool ', counter);
				    SET short_description = 'Essential gardening tool';
				    SET long_description = 'This gardening tool helps you maintain your garden with ease and efficiency.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Compact'
				                    WHEN 4 THEN 'Extended'
				                END;
				    SET picture = CONCAT('https://example.com/gardening-tools/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 18 THEN -- Video Games
				    SET product_name = CONCAT('Video Game ', counter);
				    SET short_description = 'Exciting video game';
				    SET long_description = 'Embark on thrilling adventures and enjoy immersive gameplay with this video game.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Standard'
				                    WHEN 1 THEN 'Collector''s Edition'
				                    WHEN 2 THEN 'Digital Download'
				                    WHEN 3 THEN 'Limited Edition'
				                    WHEN 4 THEN 'Deluxe Edition'
				                END;
				    SET picture = CONCAT('https://example.com/video-games/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 19 THEN -- Travel Accessories
				    SET product_name = CONCAT('Travel Accessory ', counter);
				    SET short_description = 'Convenient travel accessory';
				    SET long_description = 'This travel accessory enhances your travel experience with its practical design and functionality.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Compact'
				                    WHEN 4 THEN 'Foldable'
				                END;
				    SET picture = CONCAT('https://example.com/travel-accessories/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 20 THEN -- Baby Products
				    SET product_name = CONCAT('Baby Product ', counter);
				    SET short_description = 'Essential baby product';
				    SET long_description = 'This baby product provides comfort and care for infants, ensuring a safe environment.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Newborn'
				                    WHEN 1 THEN 'Infant'
				                    WHEN 2 THEN 'Toddler'
				                    WHEN 3 THEN 'Child'
				                    WHEN 4 THEN 'Youth'
				                END;
				    SET picture = CONCAT('https://example.com/baby-products/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 21 THEN -- Watches
				    SET product_name = CONCAT('Watch ', counter);
				    SET short_description = 'Stylish wristwatch';
				    SET long_description = 'This wristwatch combines elegance and functionality, making it a perfect accessory for any occasion.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Unisex'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/watches/', counter, '.jpg'); -- Example picture URL
				    
	            WHEN 22 THEN -- Fitness Equipment
	                SET product_name = CONCAT('Fitness Equipment ', counter);
	                SET short_description = 'Effective fitness equipment';
	                SET long_description = 'This fitness equipment helps you stay fit.';
	                SET size = ''; -- Size varies greatly, specific to each equipment
	                SET picture = CONCAT('https://example.com/fitness-equipment/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 23 THEN -- Art Supplies
	                SET product_name = CONCAT('Art Supplies ', counter);
	                SET short_description = 'High-quality art supplies';
	                SET long_description = 'These art supplies inspire your creativity.';
	                SET size = ''; -- Size can vary greatly, specific to each item
	                SET picture = CONCAT('https://example.com/art-supplies/', counter, '.jpg'); -- Example picture URL
	
	            WHEN 24 THEN -- Art Supplies
	                SET product_name = CONCAT('Art Supply ', counter);
	                SET short_description = 'High-quality art supply';
	                SET long_description = 'This art supply is essential for artists.';
	                SET size = ''; -- Size varies greatly, specific to each product
	                SET picture = CONCAT('https://example.com/art-supplies/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 25 THEN -- Party Decorations
	                SET product_name = CONCAT('Party Decoration ', counter);
	                SET short_description = 'Vibrant party decoration';
	                SET long_description = 'This party decoration adds fun to any celebration.';
	                SET size = ''; -- Size specification
	                SET picture = CONCAT('https://example.com/party-decorations/', counter, '.jpg'); -- Example picture URL
	                
	            WHEN 26 THEN -- Fishing Gear
	                SET product_name = CONCAT('Fishing Gear ', counter);
	                SET short_description = 'High-quality fishing gear';
	                SET long_description = 'This fishing gear enhances your fishing experience.';
	                SET size = ''; -- Size specification
	                SET picture = CONCAT('https://example.com/fishing-gear/', counter, '.jpg'); -- Example picture URL
	                
	            -- Add more cases for each category up to 100
	            WHEN 27 THEN -- Camping Gear
	                SET product_name = CONCAT('Camping Gear ', counter);
	                SET short_description = 'Essential camping gear';
	                SET long_description = 'This camping gear ensures a comfortable outdoor experience.';
	                SET size = ''; -- Size specification
	                SET picture = CONCAT('https://example.com/camping-gear/', counter, '.jpg'); -- Example picture URL
	            WHEN 28 THEN -- Photography Equipment
				    SET product_name = CONCAT('Photography Equipment ', counter);
				    SET short_description = 'Professional photography equipment';
				    SET long_description = 'This photography equipment captures stunning images.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/photography-equipment/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 29 THEN -- Educational Toys
				    SET product_name = CONCAT('Educational Toy ', counter);
				    SET short_description = 'Interactive educational toy';
				    SET long_description = 'This educational toy promotes learning through play.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/educational-toys/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 30 THEN -- Home Decor
				    SET product_name = CONCAT('Home Decor ', counter);
				    SET short_description = 'Stylish home decor';
				    SET long_description = 'This home decor adds elegance to any space.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/home-decor/', counter, '.jpg'); -- Example picture URL
		    	
			   	WHEN 31 THEN -- Baking Supplies
				    SET product_name = CONCAT('Baking Supply ', counter);
				    SET short_description = 'Essential baking supply';
				    SET long_description = 'This baking supply helps create delicious treats.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/baking-supplies/', counter, '.jpg'); -- Example picture URL				    
				
				WHEN 32 THEN -- Hunting Gear
				    SET product_name = CONCAT('Hunting Gear ', counter);
				    SET short_description = 'High-quality hunting gear';
				    SET long_description = 'This hunting gear ensures a successful hunt.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/hunting-gear/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 33 THEN -- Crafting Materials
				    SET product_name = CONCAT('Crafting Material ', counter);
				    SET short_description = 'Assorted crafting materials';
				    SET long_description = 'These crafting materials inspire creativity.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/crafting-materials/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 34 THEN -- Cycling Gear
				    SET product_name = CONCAT('Cycling Gear ', counter);
				    SET short_description = 'High-performance cycling gear';
				    SET long_description = 'This cycling gear enhances your ride.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/cycling-gear/', counter, '.jpg'); -- Example picture URL
		    	
			    WHEN 35 THEN -- Board Games
				    SET product_name = CONCAT('Board Game ', counter);
				    SET short_description = 'Exciting board game';
				    SET long_description = 'This board game provides hours of entertainment.';
				    SET picture = CONCAT('https://example.com/board-games/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 36 THEN -- Video Cameras
				    SET product_name = CONCAT('Video Camera ', counter);
				    SET short_description = 'High-definition video camera';
				    SET long_description = 'This video camera captures crisp, clear footage.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/video-cameras/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 37 THEN -- Computer Accessories
				    SET product_name = CONCAT('Computer Accessory ', counter);
				    SET short_description = 'Essential computer accessory';
				    SET long_description = 'This computer accessory enhances your computing experience.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/computer-accessories/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 38 THEN -- Smartphone Accessories
				    SET product_name = CONCAT('Smartphone Accessory ', counter);
				    SET short_description = 'Useful smartphone accessory';
				    SET long_description = 'This smartphone accessory adds functionality to your device.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/smartphone-accessories/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 39 THEN -- VR Headsets
				    SET product_name = CONCAT('VR Headset ', counter);
				    SET short_description = 'Immersive VR headset';
				    SET long_description = 'This VR headset transports you to virtual worlds.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/vr-headsets/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 40 THEN -- Drones
				    SET product_name = CONCAT('Drone ', counter);
				    SET short_description = 'Advanced drone';
				    SET long_description = 'This drone captures aerial views with precision.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/drones/', counter, '.jpg'); -- Example picture URL
				    				
				WHEN 41 THEN -- Home Theater Systems
				    SET product_name = CONCAT('Home Theater System ', counter);
				    SET short_description = 'Immersive home theater system';
				    SET long_description = 'This home theater system delivers cinematic sound.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/home-theater-systems/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 42 THEN -- Power Tools
				    SET product_name = CONCAT('Power Tool ', counter);
				    SET short_description = 'High-powered power tool';
				    SET long_description = 'This power tool makes tough jobs easier.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/power-tools/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 43 THEN -- Musical Equipment
				    SET product_name = CONCAT('Musical Equipment ', counter);
				    SET short_description = 'Professional musical equipment';
				    SET long_description = 'This musical equipment enhances your performance.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/musical-equipment/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 44 THEN -- Fashion Accessories
				    SET product_name = CONCAT('Fashion Accessory ', counter);
				    SET short_description = 'Stylish fashion accessory';
				    SET long_description = 'This fashion accessory complements your style.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/fashion-accessories/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 45 THEN -- Pet Apparel
				    SET product_name = CONCAT('Pet Apparel ', counter);
				    SET short_description = 'Comfortable pet apparel';
				    SET long_description = 'This pet apparel keeps your pet stylish and warm.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'XXL'
				                END;
				    SET picture = CONCAT('https://example.com/pet-apparel/', counter, '.jpg'); -- Example picture URL
				    				
				WHEN 46 THEN -- Home Lighting
				    SET product_name = CONCAT('Home Lighting ', counter);
				    SET short_description = 'Elegant home lighting solution';
				    SET long_description = 'This home lighting enhances your living space.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/home-lighting/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 47 THEN -- Bedding
				    SET product_name = CONCAT('Bedding ', counter);
				    SET short_description = 'Comfortable bedding set';
				    SET long_description = 'This bedding set provides a good night\'s sleep.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Twin'
				                    WHEN 1 THEN 'Full'
				                    WHEN 2 THEN 'Queen'
				                    WHEN 3 THEN 'King'
				                    WHEN 4 THEN 'California King'
				                END;
				    SET picture = CONCAT('https://example.com/bedding/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 48 THEN -- Bathroom Fixtures
				    SET product_name = CONCAT('Bathroom Fixture ', counter);
				    SET short_description = 'Modern bathroom fixture';
				    SET long_description = 'This bathroom fixture adds elegance to your bathroom.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/bathroom-fixtures/', counter, '.jpg'); -- Example picture URL
				    				
				WHEN 49 THEN -- Hand Tools
				    SET product_name = CONCAT('Hand Tool ', counter);
				    SET short_description = 'Essential hand tool';
				    SET long_description = 'This hand tool is perfect for DIY projects.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/hand-tools/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 50 THEN -- Food Processors
				    SET product_name = CONCAT('Food Processor ', counter);
				    SET short_description = 'Versatile food processor';
				    SET long_description = 'This food processor simplifies meal preparation.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/food-processors/', counter, '.jpg'); -- Example picture URL
	
				WHEN 51 THEN -- Hair Care Products
				    SET product_name = CONCAT('Hair Care Product ', counter);
				    SET short_description = 'Effective hair care product';
				    SET long_description = 'This hair care product nourishes and strengthens hair.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/hair-care-products/', counter, '.jpg'); -- Example picture URL
				
			    WHEN 52 THEN -- Nail Care Products
				    SET product_name = CONCAT('Nail Care Product ', counter);
				    SET short_description = 'Quality nail care product';
				    SET long_description = 'This nail care product keeps your nails healthy and beautiful.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/nail-care-products/', counter, '.jpg'); -- Example picture URL
				    				
				WHEN 53 THEN -- Personal Hygiene Products
				    SET product_name = CONCAT('Personal Hygiene Product ', counter);
				    SET short_description = 'Essential personal hygiene product';
				    SET long_description = 'This personal hygiene product keeps you clean and fresh.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/personal-hygiene-products/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 54 THEN -- Sustainable Products
				    SET product_name = CONCAT('Sustainable Product ', counter);
				    SET short_description = 'Eco-friendly sustainable product';
				    SET long_description = 'This sustainable product helps reduce environmental impact.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/sustainable-products/', counter, '.jpg'); -- Example picture URL
				    				
				WHEN 55 THEN -- Luxury Goods
				    SET product_name = CONCAT('Luxury Good ', counter);
				    SET short_description = 'Exquisite luxury good';
				    SET long_description = 'This luxury good represents elegance and prestige.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/luxury-goods/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 56 THEN -- Outdoor Furniture
				    SET product_name = CONCAT('Outdoor Furniture ', counter);
				    SET short_description = 'Durable outdoor furniture';
				    SET long_description = 'This outdoor furniture enhances your outdoor living space.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/outdoor-furniture/', counter, '.jpg'); -- Example picture URL				    
				
				WHEN 57 THEN -- Exercise Equipment
				    SET product_name = CONCAT('Exercise Equipment ', counter);
				    SET short_description = 'High-quality exercise equipment';
				    SET long_description = 'This exercise equipment helps you stay fit and healthy.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/exercise-equipment/', counter, '.jpg'); -- Example picture URL
				    
				
				
				WHEN 58 THEN -- Musical Instruments
				    SET product_name = CONCAT('Musical Instrument ', counter);
				    SET short_description = 'Quality musical instrument';
				    SET long_description = 'This musical instrument produces beautiful sounds.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/musical-instruments/', counter, '.jpg'); -- Example picture URL				    
				
				
				WHEN 59 THEN -- Pet Supplies
				    SET product_name = CONCAT('Pet Supply ', counter);
				    SET short_description = 'Essential pet supply';
				    SET long_description = 'This pet supply keeps your pet healthy and happy.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/pet-supplies/', counter, '.jpg'); -- Example picture URL
				   				
				
				WHEN 60 THEN -- Office Supplies
				    SET product_name = CONCAT('Office Supply ', counter);
				    SET short_description = 'Functional office supply';
				    SET long_description = 'This office supply enhances productivity and organization.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/office-supplies/', counter, '.jpg'); -- Example picture URL
				    
				
				
				WHEN 61 THEN -- Art Supplies
				    SET product_name = CONCAT('Art Supply ', counter);
				    SET short_description = 'Creative art supply';
				    SET long_description = 'This art supply inspires creativity and artistic expression.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/art-supplies/', counter, '.jpg'); -- Example picture URL
				    
				
				
				WHEN 62 THEN -- Home Appliances
				    SET product_name = CONCAT('Home Appliance ', counter);
				    SET short_description = 'Efficient home appliance';
				    SET long_description = 'This home appliance makes daily tasks easier and more convenient.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/home-appliances/', counter, '.jpg'); -- Example picture URL
				   

				
				WHEN 63 THEN -- Baby Products
				    SET product_name = CONCAT('Baby Product ', counter);
				    SET short_description = 'Safe and comfortable baby product';
				    SET long_description = 'This baby product ensures safety and comfort for infants.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/baby-products/', counter, '.jpg'); -- Example picture URL
				   
				

				
				WHEN 64 THEN -- Automotive Accessories
				    SET product_name = CONCAT('Automotive Accessory ', counter);
				    SET short_description = 'Useful automotive accessory';
				    SET long_description = 'This automotive accessory enhances vehicle functionality and style.';
				    SET size = ''; -- Size specification
				    SET picture = CONCAT('https://example.com/automotive-accessories/', counter, '.jpg'); -- Example picture URL
				    
				
				
				WHEN 65 THEN -- Kitchen Appliances
				    SET product_name = CONCAT('Kitchen Appliance ', counter);
				    SET short_description = 'Efficient kitchen appliance';
				    SET long_description = 'This kitchen appliance simplifies cooking and food preparation.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/kitchen-appliances/', counter, '.jpg'); -- Example picture URL
				   
				
				WHEN 66 THEN -- Sporting Goods
				    SET product_name = CONCAT('Sporting Good ', counter);
				    SET short_description = 'High-performance sporting good';
				    SET long_description = 'This sporting good enhances athletic performance and enjoyment.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/sporting-goods/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 67 THEN -- Gardening Supplies
				    SET product_name = CONCAT('Gardening Supply ', counter);
				    SET short_description = 'Effective gardening supply';
				    SET long_description = 'This gardening supply helps you maintain a beautiful garden.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/gardening-supplies/', counter, '.jpg'); -- Example picture URL
				    				
				WHEN 68 THEN -- Books
				    SET product_name = CONCAT('Book ', counter);
				    SET short_description = 'Inspiring book';
				    SET long_description = 'This book inspires and enriches the mind.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Pocket-sized'
				                    WHEN 1 THEN 'Small'
				                    WHEN 2 THEN 'Medium'
				                    WHEN 3 THEN 'Large'
				                    WHEN 4 THEN 'Oversized'
				                END;
				    SET picture = CONCAT('https://example.com/books/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 69 THEN -- Electronic Devices
				    SET product_name = CONCAT('Electronic Device ', counter);
				    SET short_description = 'Advanced electronic device';
				    SET long_description = 'This electronic device combines innovation with functionality.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Portable'
				                END;
				    SET picture = CONCAT('https://example.com/electronic-devices/', counter, '.jpg'); -- Example picture URL
				   
				
				WHEN 70 THEN -- Clothing
				    SET product_name = CONCAT('Clothing ', counter);
				    SET short_description = 'Stylish clothing item';
				    SET long_description = 'This clothing item is comfortable and fashionable.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'XS'
				                    WHEN 1 THEN 'S'
				                    WHEN 2 THEN 'M'
				                    WHEN 3 THEN 'L'
				                    WHEN 4 THEN 'XL'
				                END;
				    SET picture = CONCAT('https://example.com/clothing/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 71 THEN -- Beauty Products
				    SET product_name = CONCAT('Beauty Product ', counter);
				    SET short_description = 'Enhancing beauty product';
				    SET long_description = 'This beauty product enhances your natural beauty.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Travel Size'
				                END;
				    SET picture = CONCAT('https://example.com/beauty-products/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 72 THEN -- Furniture
				    SET product_name = CONCAT('Furniture ', counter);
				    SET short_description = 'Stylish and functional furniture piece';
				    SET long_description = 'This furniture piece combines style with practicality.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/furniture/', counter, '.jpg'); -- Example picture URL
				    

				
				WHEN 73 THEN -- Toys and Games
				    SET product_name = CONCAT('Toy or Game ', counter);
				    SET short_description = 'Fun and educational toy or game';
				    SET long_description = 'This toy or game provides hours of entertainment and learning.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Jumbo'
				                END;
				    SET picture = CONCAT('https://example.com/toys-and-games/', counter, '.jpg'); -- Example picture URL
				    

				
				WHEN 74 THEN -- Pet Supplies
				    SET product_name = CONCAT('Pet Supply ', counter);
				    SET short_description = 'Essential pet supply';
				    SET long_description = 'This pet supply enhances the well-being of your pet.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/pet-supplies/', counter, '.jpg'); -- Example picture URL
				WHEN 75 THEN -- Health and Wellness
				    SET product_name = CONCAT('Health and Wellness Product ', counter);
				    SET short_description = 'Promoting health and wellness';
				    SET long_description = 'This health and wellness product supports your well-being.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Travel Size'
				                END;
				    SET picture = CONCAT('https://example.com/health-and-wellness/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 76 THEN -- Home Decor
				    SET product_name = CONCAT('Home Decor ', counter);
				    SET short_description = 'Enhancing home decor item';
				    SET long_description = 'This home decor item adds style and elegance to your living space.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/home-decor/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 77 THEN -- Office Supplies
				    SET product_name = CONCAT('Office Supply ', counter);
				    SET short_description = 'Essential office supply';
				    SET long_description = 'This office supply helps you stay organized and productive.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/office-supplies/', counter, '.jpg'); -- Example picture URL
				  
				WHEN 78 THEN -- Musical Instruments
				    SET product_name = CONCAT('Musical Instrument ', counter);
				    SET short_description = 'Quality musical instrument';
				    SET long_description = 'This musical instrument delivers exceptional sound quality.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Professional Size'
				                END;
				    SET picture = CONCAT('https://example.com/musical-instruments/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 79 THEN -- Jewelry
				    SET product_name = CONCAT('Jewelry ', counter);
				    SET short_description = 'Elegant jewelry piece';
				    SET long_description = 'This jewelry piece adds sophistication to any outfit.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/jewelry/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 80 THEN -- Automotive Parts and Accessories
				    SET product_name = CONCAT('Automotive Part or Accessory ', counter);
				    SET short_description = 'Quality automotive part or accessory';
				    SET long_description = 'This automotive part or accessory enhances vehicle performance or aesthetics.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/automotive-parts/', counter, '.jpg'); -- Example picture URL
				    
			    WHEN 81 THEN -- Fashion Accessories
				    SET product_name = CONCAT('Fashion Accessory ', counter);
				    SET short_description = 'Stylish fashion accessory';
				    SET long_description = 'This fashion accessory complements your outfit with style and elegance.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'One Size'
				                END;
				    SET picture = CONCAT('https://example.com/fashion-accessories/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 82 THEN -- Pet Apparel
				    SET product_name = CONCAT('Pet Apparel ', counter);
				    SET short_description = 'Stylish apparel for pets';
				    SET long_description = 'This pet apparel keeps your furry friend stylish and comfortable.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Extra Small'
				                    WHEN 1 THEN 'Small'
				                    WHEN 2 THEN 'Medium'
				                    WHEN 3 THEN 'Large'
				                    WHEN 4 THEN 'Extra Large'
				                END;
				    SET picture = CONCAT('https://example.com/pet-apparel/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 83 THEN -- Home Lighting
				    SET product_name = CONCAT('Home Lighting ', counter);
				    SET short_description = 'Functional home lighting';
				    SET long_description = 'This home lighting fixture illuminates your living space with style and functionality.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/home-lighting/', counter, '.jpg'); -- Example picture URL
				    
			    WHEN 84 THEN -- Bedding
				    SET product_name = CONCAT('Bedding ', counter);
				    SET short_description = 'Comfortable bedding set';
				    SET long_description = 'This bedding set ensures a comfortable and cozy sleep experience.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Twin'
				                    WHEN 1 THEN 'Full'
				                    WHEN 2 THEN 'Queen'
				                    WHEN 3 THEN 'King'
				                    WHEN 4 THEN 'California King'
				                END;
				    SET picture = CONCAT('https://example.com/bedding/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 85 THEN -- Bathroom Fixtures
				    SET product_name = CONCAT('Bathroom Fixture ', counter);
				    SET short_description = 'Functional bathroom fixture';
				    SET long_description = 'This bathroom fixture enhances your bathroom with functionality and style.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/bathroom-fixtures/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 86 THEN -- Hand Tools
				    SET product_name = CONCAT('Hand Tool ', counter);
				    SET short_description = 'Versatile hand tool';
				    SET long_description = 'This hand tool helps you tackle various DIY projects with ease and precision.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Compact'
				                END;
				    SET picture = CONCAT('https://example.com/hand-tools/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 87 THEN -- Food Processors
				    SET product_name = CONCAT('Food Processor ', counter);
				    SET short_description = 'Efficient food processor';
				    SET long_description = 'This food processor simplifies food preparation with its powerful and efficient design.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Compact'
				                END;
				    SET picture = CONCAT('https://example.com/food-processors/', counter, '.jpg'); -- Example picture URL
				    
			    WHEN 88 THEN -- Hair Care Products
			    
				    SET product_name = CONCAT('Hair Care Product ', counter);
				    SET short_description = 'Quality hair care product';
				    SET long_description = 'This hair care product enhances your hair\'s health and appearance with its premium ingredients.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Travel Size'
				                    WHEN 4 THEN 'Family Size'
				                END;
				    SET picture = CONCAT('https://example.com/hair-care-products/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 89 THEN -- Nail Care Products
				    SET product_name = CONCAT('Nail Care Product ', counter);
				    SET short_description = 'Effective nail care product';
				    SET long_description = 'This nail care product keeps your nails healthy and beautiful with its nourishing formula.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Travel Size'
				                    WHEN 4 THEN 'Professional Size'
				                END;
				    SET picture = CONCAT('https://example.com/nail-care-products/', counter, '.jpg'); -- Example picture URL
				    
		    	WHEN 90 THEN -- Personal Hygiene Products
				    SET product_name = CONCAT('Personal Hygiene Product ', counter);
				    SET short_description = 'Essential personal hygiene product';
				    SET long_description = 'This personal hygiene product ensures cleanliness and freshness throughout the day.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Travel Size'
				                    WHEN 4 THEN 'Family Size'
				                END;
				    SET picture = CONCAT('https://example.com/personal-hygiene-products/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 91 THEN -- Sustainable Products
				    SET product_name = CONCAT('Sustainable Product ', counter);
				    SET short_description = 'Environmentally sustainable product';
				    SET long_description = 'This sustainable product is made with eco-friendly materials, promoting environmental conservation.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/sustainable-products/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 92 THEN -- Luxury Goods
				    SET product_name = CONCAT('Luxury Good ', counter);
				    SET short_description = 'Exquisite luxury good';
				    SET long_description = 'This luxury good exemplifies elegance and sophistication, crafted with the finest materials.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Extra Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/luxury-goods/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 93 THEN -- Remote Control Toys
				    SET product_name = CONCAT('Remote Control Toy ', counter);
				    SET short_description = 'Fun remote control toy';
				    SET long_description = 'This remote control toy provides hours of entertainment with its responsive controls and exciting features.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Mini'
				                    WHEN 1 THEN 'Small'
				                    WHEN 2 THEN 'Medium'
				                    WHEN 3 THEN 'Large'
				                    WHEN 4 THEN 'Giant'
				                END;
				    SET picture = CONCAT('https://example.com/remote-control-toys/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 94 THEN -- Building Materials
				    SET product_name = CONCAT('Building Material ', counter);
				    SET short_description = 'Quality building material';
				    SET long_description = 'This building material is essential for construction and renovation projects, offering durability and reliability.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Bulk'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/building-materials/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 95 THEN -- Fitness Trackers
				    SET product_name = CONCAT('Fitness Tracker ', counter);
				    SET short_description = 'Advanced fitness tracker';
				    SET long_description = 'This fitness tracker monitors your daily activities and helps you achieve your fitness goals with precision.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Small'
				                    WHEN 1 THEN 'Medium'
				                    WHEN 2 THEN 'Large'
				                    WHEN 3 THEN 'Adjustable'
				                    WHEN 4 THEN 'One Size'
				                END;
				    SET picture = CONCAT('https://example.com/fitness-trackers/', counter, '.jpg'); -- Example picture URL
				    
				WHEN 96 THEN -- Smart Home Devices
				    SET product_name = CONCAT('Smart Home Device ', counter);
				    SET short_description = 'Intelligent smart home device';
				    SET long_description = 'This smart home device enhances your home automation setup with its advanced features and seamless integration.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'Compact'
				                    WHEN 1 THEN 'Small'
				                    WHEN 2 THEN 'Medium'
				                    WHEN 3 THEN 'Large'
				                    WHEN 4 THEN 'Custom'
				                END;
				    SET picture = CONCAT('https://example.com/smart-home-devices/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 97 THEN -- Outdoor Clothing
				    SET product_name = CONCAT('Outdoor Clothing ', counter);
				    SET short_description = 'Durable outdoor clothing';
				    SET long_description = 'This outdoor clothing is designed for comfort and durability during outdoor adventures and activities.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'XS'
				                    WHEN 1 THEN 'S'
				                    WHEN 2 THEN 'M'
				                    WHEN 3 THEN 'L'
				                    WHEN 4 THEN 'XL'
				                END;
				    SET picture = CONCAT('https://example.com/outdoor-clothing/', counter, '.jpg'); -- Example picture URL
				    
				
				WHEN 98 THEN -- Winter Sports Gear
				    SET product_name = CONCAT('Winter Sports Gear ', counter);
				    SET short_description = 'High-performance winter sports gear';
				    SET long_description = 'This winter sports gear enhances your performance and comfort during snowy adventures and sports activities.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN 'XS'
				                    WHEN 1 THEN 'S'
				                    WHEN 2 THEN 'M'
				                    WHEN 3 THEN 'L'
				                    WHEN 4 THEN 'XL'
				                    END;
				    SET picture = CONCAT('https://example.com/winter-sports-gear/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 99 THEN -- Fishing Rods
				    SET product_name = CONCAT('Fishing Rod ', counter);
				    SET short_description = 'High-quality fishing rod';
				    SET long_description = 'This fishing rod offers superior performance and durability, making it ideal for fishing enthusiasts.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN '6 ft'
				                    WHEN 1 THEN '7 ft'
				                    WHEN 2 THEN '8 ft'
				                    WHEN 3 THEN '9 ft'
				                    WHEN 4 THEN '10 ft'
				                END;
				    SET picture = CONCAT('https://example.com/fishing-rods/', counter, '.jpg'); -- Example picture URL
				   
				WHEN 100 THEN -- Ski Equipment
				    SET product_name = CONCAT('Ski Equipment ', counter);
				    SET short_description = 'Premium ski equipment';
				    SET long_description = 'This ski equipment is designed for performance and comfort, ensuring an enjoyable skiing experience.';
				    SET size = CASE FLOOR(RAND() * 5)
				                    WHEN 0 THEN '150 cm'
				                    WHEN 1 THEN '160 cm'
				                    WHEN 2 THEN '170 cm'
				                    WHEN 3 THEN '180 cm'
				                    WHEN 4 THEN '190 cm'
				                END;
				    SET picture = CONCAT('https://example.com/ski-equipment/', counter, '.jpg'); -- Example picture URL
				   
	        END CASE;
	       
	        SET color = CASE FLOOR(RAND() * 5)
	                                    WHEN 0 THEN 'Black'
	                                    WHEN 1 THEN 'Silver'
	                                    WHEN 2 THEN 'White'
	                                    WHEN 3 THEN 'Gray'
	                                    WHEN 4 THEN 'Blue'
	                                END;
			SET weight = ROUND(RAND() * 5 + 1, 2); 
			SET price = ROUND(RAND() * 1000 + 100, 2); 
			SET quantity = FLOOR(RAND() * 50 + 50);
			SET discounts = ROUND(RAND() * 30, 2);
			SET shipping_cost = ROUND(RAND() * 20 + 5, 2);
			SET is_available = 1;

            SET @product_values = CONCAT(@product_values, '(', QUOTE(product_name), ',', IFNULL(QUOTE(short_description), 'NULL'), ',', IFNULL(QUOTE(long_description), 'NULL'), ',', IFNULL(QUOTE(size), 'NULL'), ',',  IFNULL(QUOTE(color), 'NULL'), ',',  IFNULL(QUOTE(weight), 'NULL'), ',', QUOTE(price), ',', QUOTE(quantity), ',', IFNULL(QUOTE(picture), 'NULL'), ',', QUOTE(discounts), ',', QUOTE(shipping_cost), ',', QUOTE(is_available), '),');
            SET @product_categroy_values = CONCAT(@product_categroy_values, '(',QUOTE(category_id),',', QUOTE(counter), ',', '1', '),');
            	
	        SET counter = counter + 1;
        END WHILE;
       
        SET @product_insert = CONCAT(@product_insert, LEFT(@product_values, LENGTH(@product_values) - 1));
        PREPARE stmt1 FROM @product_insert;
        EXECUTE stmt1;
        DEALLOCATE PREPARE stmt1;
        
        SET @product_categroy_insert = CONCAT(@product_categroy_insert, LEFT(@product_categroy_values, LENGTH(@product_categroy_values) - 1));
        PREPARE stmt2 FROM @product_categroy_insert;
        EXECUTE stmt2;
        DEALLOCATE PREPARE stmt2;
        
        COMMIT;
       
    END WHILE;

   
   -- Final commit
    COMMIT;
   
    SELECT 'Data insertion completed.' AS Result;
END

call InsertRandomProducts();

