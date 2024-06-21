
CREATE PROCEDURE InsertRandomProductCategories()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE category_names_list TEXT;
    DECLARE category_descriptions_list TEXT;
    DECLARE category_name VARCHAR(100);
    DECLARE category_description VARCHAR(1000);
    DECLARE parent_id INT;
    
    SET category_names_list = 'Electronics, Clothing, Home Appliances, Books, Sports Equipment, Beauty Products, Toys, Furniture, Automotive Parts, Outdoor Gear, Kitchenware, Pet Supplies, Health Supplements, Jewelry, Musical Instruments, Office Supplies, Gardening Tools, Video Games, Travel Accessories, Baby Products, Watches, Fitness Equipment, Art Supplies, Party Decorations, Fishing Gear, Camping Gear, Cookware, Cosmetics, Board Games, Photography Equipment, Educational Toys, Home Decor, Baking Supplies, Hunting Gear, Crafting Materials, Cycling Gear, Board Games, Video Cameras, Computer Accessories, Smartphone Accessories, VR Headsets, Drones, Home Theater Systems, Power Tools, Musical Equipment, Fashion Accessories, Pet Apparel, Home Lighting, Bedding, Bathroom Fixtures, Hand Tools, Food Processors, Hair Care Products, Nail Care Products, Personal Hygiene Products, Sustainable Products, Luxury Goods, Remote Control Toys, Building Materials, Fitness Trackers, Smart Home Devices, Outdoor Clothing, Winter Sports Gear, Fishing Rods, Ski Equipment, Camping Tents, Climbing Gear, Outdoor Footwear, Golf Clubs, Running Shoes, Yoga Mats, Exercise Balls, Skateboards, Swimming Gear, Water Sports Equipment, Beach Accessories, Sunglasses, Backpacks, Exercise Bikes, Rowing Machines, Boxing Gloves, Martial Arts Gear, Archery Equipment, Tennis Rackets, Basketball Gear, Baseball Bats, Football Equipment, Soccer Gear, Volleyball Gear, Rugby Equipment, Cricket Gear, Table Tennis Equipment, Badminton Gear, Snorkeling Equipment, Diving Gear, Surfing Gear, Skateboarding Gear, Roller Skates, Ice Skates, Inline Skates, Scooters, Hoverboards, Electric Bicycles, Pedal Bicycles';
    
    SET category_descriptions_list = 'Electronics and gadgets for every need., Stylish apparel for every occasion., Appliances to simplify your life., Books for every interest., Equipment for all your sports needs., Beauty products for every skin type., Toys for every age., Furniture for every room., Automotive parts for every vehicle., Gear for outdoor adventures., Kitchenware for cooking enthusiasts., Supplies for your pets., Supplements for better health., Jewelry for every occasion., Instruments for every musician., Supplies for your office., Tools for your garden., Games for every player., Accessories for your travels., Products for babies., Watches for every style., Equipment for fitness., Supplies for art., Decorations for parties., Gear for fishing., Gear for camping., Cookware for cooking., Products for beauty., Games for entertainment., Equipment for photography., Toys for learning., Decor for homes., Supplies for baking., Gear for hunting., Materials for crafting., Gear for cycling., Games for entertainment., Cameras for videos., Accessories for computers., Accessories for phones., Headsets for VR., Devices for drones., Systems for home theater., Tools for power., Equipment for music., Accessories for fashion., Apparel for pets., Lighting for homes., Bedding for comfort., Fixtures for bathrooms., Tools for hands., Processors for food., Products for hair., Products for nails., Products for hygiene., Products for sustainability., Goods for luxury., Toys for remote control., Materials for building., Trackers for fitness., Devices for homes., Clothing for outdoors., Gear for winter sports., Rods for fishing., Equipment for skiing., Tents for camping., Gear for climbing., Footwear for outdoors., Clubs for golf., Shoes for running., Mats for yoga., Balls for exercise., Boards for skate., Gear for swimming., Equipment for sports., Accessories for beach., Glasses for sun., Packs for backs., Bikes for exercise., Machines for rowing., Gloves for boxing., Gear for martial arts., Equipment for archery., Rackets for tennis., Gear for basketball., Bats for baseball., Equipment for football., Gear for soccer., Gear for volleyball., Equipment for rugby., Gear for cricket., Equipment for table tennis., Gear for badminton., Equipment for snorkeling., Gear for diving., Gear for surfing., Gear for skateboarding., Skates for rollers., Skates for ice., Skates for inline., Scooters for fun., Boards for hover., Bicycles for electric., Bicycles for pedal.';
    
    WHILE counter <= 100 DO
        SET category_name = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(category_names_list, ',', counter), ',', -1));
        SET category_description = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(category_descriptions_list, ',', counter), ',', -1));
        
        SET parent_id = NULL;  -- Assume categories have no parent
        
        INSERT INTO CATEGORY (NAME, DESCRIPTION, PARENT_ID)
        VALUES (category_name, category_description, parent_id);
        
        SET counter = counter + 1;
    END WHILE;
    
    SELECT 'Data insertion completed.' AS Result;
end



CALL InsertRandomProductCategories();



