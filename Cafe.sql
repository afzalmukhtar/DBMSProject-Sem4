
use cafe;
drop tables customer, employee, items, menu, orders;

CREATE TABLE `customer` (
    `c_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `fname` VARCHAR(25) NOT NULL DEFAULT '',
    `lname` VARCHAR(25) DEFAULT NULL,
    `phone` VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (`c_id`)
)  ENGINE=INNODB AUTO_INCREMENT=10001 DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

CREATE TABLE `employee` (
    `e_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `fname` VARCHAR(25) NOT NULL DEFAULT '',
    `lname` VARCHAR(25) DEFAULT '',
    `phone` VARCHAR(10) NOT NULL,
    `addr` TEXT,
    `pay` FLOAT NOT NULL,
    PRIMARY KEY (`e_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

CREATE TABLE `menu` (
    `food_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `food_name` TEXT NOT NULL,
    `price` FLOAT NOT NULL,
    PRIMARY KEY (`food_id`)
)  ENGINE=INNODB AUTO_INCREMENT=201 DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

CREATE TABLE `orders` (
    `o_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `order_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `cus_id` INT UNSIGNED NOT NULL,
    `emp_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`o_id`),
    KEY `cus_id` (`cus_id`),
    KEY `emp_id` (`emp_id`),
    CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`cus_id`)
        REFERENCES `customer` (`c_id`),
    CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`emp_id`)
        REFERENCES `employee` (`e_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

CREATE TABLE `items` (
    `item_name` TEXT NOT NULL,
    `quantity` INT UNSIGNED NOT NULL DEFAULT '1',
    `order_id` INT UNSIGNED NOT NULL,
    `food_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`order_id` , `food_id`),
    KEY `food_id` (`food_id`),
    CONSTRAINT `items_ibfk_1` FOREIGN KEY (`order_id`)
        REFERENCES `orders` (`o_id`),
    CONSTRAINT `items_ibfk_2` FOREIGN KEY (`food_id`)
        REFERENCES `menu` (`food_id`)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4 COLLATE = UTF8MB4_0900_AI_CI;

DROP TRIGGER IF EXISTS `cafe`.`menu_BEFORE_DELETE`;
DELIMITER $$
USE `cafe`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `menu_BEFORE_DELETE` BEFORE DELETE ON `menu` FOR EACH ROW BEGIN
if(exists(select items.food_id from items where items.food_id = old.food_id)) then
		delete from items where items.food_id = old.food_id;
end if;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `cafe`.`menu_AFTER_UPDATE`;
DELIMITER $$
USE `cafe`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cafe`.`menu_AFTER_UPDATE` AFTER UPDATE ON `menu` FOR EACH ROW
BEGIN
if(exists(select items.item_name from items where items.item_name = old.food_name)) then
	update items set items.item_name = new.food_name where items.item_name = old.food_name;
end if;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `cafe`.`employee_BEFORE_DELETE`;
DELIMITER $$
USE `cafe`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cafe`.`employee_BEFORE_DELETE` BEFORE DELETE ON `employee` FOR EACH ROW
BEGIN
if(exists(select emp_id from orders where emp_id = old.e_id)) then
	delete from orders where emp_id = old.e_id;
end if;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `cafe`.`employee_BEFORE_INSERT`;
DELIMITER $$
USE `cafe`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cafe`.`employee_BEFORE_INSERT` BEFORE INSERT ON `employee` FOR EACH ROW
BEGIN
DECLARE MSG varchar(255);
if(exists(select * from employee where fname = new.fname and lname = new.lname and phone = new.phone)) then
	set MSG = 'Employee Already Exists';
    SIGNAL SQLSTATE '42000' SET MESSAGE_TEXT = msg;
end if;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `cafe`.`orders_BEFORE_DELETE`;
DELIMITER $$
USE `cafe`$$
CREATE DEFINER = CURRENT_USER TRIGGER `cafe`.`orders_BEFORE_DELETE` BEFORE DELETE ON `orders` FOR EACH ROW
BEGIN
if(exists(select o_id from orders where o_id = old.o_id)) then
	delete from items where items.order_id = old.o_id;
end if;
END$$
DELIMITER ;

insert into customer(fname, lname, phone) values('Washington', 'Crawford', '8629105950');
insert into customer(fname, lname, phone) values('Daniele', 'Hardy', '9798017942');
insert into customer(fname, lname, phone) values('Mariya', 'Geraint', '8613132461');
insert into customer(fname, lname, phone) values('Kaitlin', 'Easton', '8123415356');
insert into customer(fname, lname, phone) values('Curtis', 'Nixon', '9150870659');
insert into customer(fname, lname, phone) values('Cotton', 'Potter', '9026652541');
insert into customer(fname, lname, phone) values('Brian', 'Forster', '9411998827');
insert into customer(fname, lname, phone) values('Jorge', 'Alyssa', '8714319448');
insert into customer(fname, lname, phone) values('Couch', 'Kezia', '9850093926');
insert into customer(fname, lname, phone) values('Eliott', 'Fred', '9215655997');
insert into customer(fname, lname, phone) values('Ramsey', 'Dalton', '9983800401');
insert into customer(fname, lname, phone) values('Chang', 'Uzair', '8574779531');
insert into customer(fname, lname, phone) values('Alisa', 'Whelan', '8125943406');
insert into customer(fname, lname, phone) values('Sharpe', 'Day', '9379802237');
insert into customer(fname, lname, phone) values('Atkinson', 'Suranne', '9650607846');
insert into customer(fname, lname, phone) values('Amber-Rose', 'Tymoteusz', '8410794677');
insert into customer(fname, lname, phone) values('Busby', 'Aiysha', '9920427697');
insert into customer(fname, lname, phone) values('Brooke', 'Baker', '8098454689');
insert into customer(fname, lname, phone) values('Baldwin', 'Cooke', '9169905652');
insert into customer(fname, lname, phone) values('Le', 'Mahek', '9869760193');
insert into customer(fname, lname, phone) values('Bond', 'Hammond', '8103780515');
insert into customer(fname, lname, phone) values('Prince', 'Mallory', '8899905806');
insert into customer(fname, lname, phone) values('Benny', 'Shelby', '9846963455');
insert into customer(fname, lname, phone) values('Hakim', 'Whitaker', '8626370965');
insert into customer(fname, lname, phone) values('Carney', 'Vienna', '9658616668');
insert into customer(fname, lname, phone) values('Jennifer', 'Gallagher', '9222238883');
insert into customer(fname, lname, phone) values('Lola-Rose', 'Carole', '8698128786');
insert into customer(fname, lname, phone) values('Xanthe', 'Seb', '8780470883');
insert into customer(fname, lname, phone) values('Portillo', 'Riddle', '8975326659');
insert into customer(fname, lname, phone) values('Rogers', 'Ho', '9235846224');
insert into customer(fname, lname, phone) values('Kyron', 'Humphreys', '9692613171');
insert into customer(fname, lname, phone) values('Milo', 'Rollins', '9287989110');
insert into customer(fname, lname, phone) values('Spence', 'Iolo', '9011358430');
insert into customer(fname, lname, phone) values('Alicja', 'Kamile', '9727505106');
insert into customer(fname, lname, phone) values('Mcdonnell', 'Jenson', '8203001031');
insert into customer(fname, lname, phone) values('Malik', 'Jarvis', '8935703001');
insert into customer(fname, lname, phone) values('Watson', 'Lyons', '8938361404');
insert into customer(fname, lname, phone) values('Jayden-James', 'Gould', '8015515659');
insert into customer(fname, lname, phone) values('Castro', 'Bridges', '9795337661');
insert into customer(fname, lname, phone) values('Reeves', 'Marta', '8050103705');
insert into customer(fname, lname, phone) values('Halimah', 'Tommy', '9664817654');
insert into customer(fname, lname, phone) values('Kinney', 'Riaz', '9095156040');
insert into customer(fname, lname, phone) values('Buckley', 'Abu', '8900437478');
insert into customer(fname, lname, phone) values('Buxton', 'Wilma', '8587481764');
insert into customer(fname, lname, phone) values('Gertrude', 'Ware', '8644602958');
insert into customer(fname, lname, phone) values('Jared', 'Mccarthy', '8701458599');
insert into customer(fname, lname, phone) values('Bentley', 'Lawson', '9069255530');
insert into customer(fname, lname, phone) values('Mackie', 'Abby', '9591766665');
insert into customer(fname, lname, phone) values('Sienna', 'Berat', '9512445050');
insert into customer(fname, lname, phone) values('Maksymilian', 'Rhea', '9729346269');
SELECT 
    *
FROM
    customer;


insert into employee(fname, lname, phone, addr, pay) values('Watson', 'Iolo', '9571873046', '754 Albany Rd. Dalton, GA 30721', '2500');
insert into employee(fname, lname, phone, addr, pay) values('Rhea', 'Ware', '8200353144', '174 Woodland St. North Olmsted, OH 44070', '4800');
insert into employee(fname, lname, phone, addr, pay) values('Kinney', 'Riddle', '8386480064', '956 Division Ave. Trenton, NJ 08610', '4900');
insert into employee(fname, lname, phone, addr, pay) values('Buckley', 'Jennifer', '8620144781', '294 SW. Cedar Swamp Street Elkridge, MD 21075', '5000');
insert into employee(fname, lname, phone, addr, pay) values('Abby', 'Lyons', '9849192647', '8256 Paris Hill Street Brainerd, MN 56401', '2300');
insert into employee(fname, lname, phone, addr, pay) values('Washington', 'Whitaker', '9248681387', '787 Lancaster Road Elkhart, IN 46514', '4600');
insert into employee(fname, lname, phone, addr, pay) values('Suranne', 'Mcdonnell', '8359997625', '387 Squaw Creek Dr. West Chester, PA 19380', '3100');
insert into employee(fname, lname, phone, addr, pay) values('Alyssa', 'Amber-Rose', '9725762821', '9076 E. Rock Maple St. Fairfield, CT 06824', '2800');
insert into employee(fname, lname, phone, addr, pay) values('Fred', 'Portillo', '9496970692', '9402 Cooper Ave. Streamwood, IL 60107', '3700');
insert into employee(fname, lname, phone, addr, pay) values('Daniele', 'Tommy', '9017125119', '7 West Edgemont Street Nashville, TN 37205', '4100');
insert into employee(fname, lname, phone, addr, pay) values('Jayden-James', 'Alisa', '9844027123', '92 South Woodland Rd. Oviedo, FL 32765', '4800');
insert into employee(fname, lname, phone, addr, pay) values('Potter', 'Cooke', '8019155871', '9833 Yukon Ave. Malvern, PA 19355', '2700');
insert into employee(fname, lname, phone, addr, pay) values('Malik', 'Gallagher', '8146089652', '40 Gainsway St. Lockport, NY 14094', '2400');
insert into employee(fname, lname, phone, addr, pay) values('Ho', 'Mackie', '8749559822', '25 Oak Meadow Rd. Minneapolis, MN 55406', '2200');
insert into employee(fname, lname, phone, addr, pay) values('Bond', 'Lawson', '8142212578', '8950 N. Oakland Ave. Saint Joseph, MI 49085', '2200');
insert into employee(fname, lname, phone, addr, pay) values('Kaitlin', 'Abu', '9556900845', '637 Madison St. Dekalb, IL 60115', '3900');
insert into employee(fname, lname, phone, addr, pay) values('Xanthe', 'Halimah', '9553377341', '7044 W. Sleepy Hollow St. Middle Village, NY 11379', '2400');
insert into employee(fname, lname, phone, addr, pay) values('Forster', 'Baldwin', '8749776592', '10 Randall Mill Lane Key West, FL 33040', '2200');
insert into employee(fname, lname, phone, addr, pay) values('Baker', 'Sharpe', '9387955858', '16 Bridgeton Dr. Windsor Mill, MD 21244', '3000');
insert into employee(fname, lname, phone, addr, pay) values('Bridges', 'Jenson', '8804480998', '57 Adams Ave. Owosso, MI 48867', '4200');
insert into employee(fname, lname, phone, addr, pay) values('Castro', 'Day', '8475247925', '49 Applegate Ave. Horn Lake, MS 38637', '2600');
insert into employee(fname, lname, phone, addr, pay) values('Atkinson', 'Busby', '9274841311', '8355 South Birchpond Dr. Mcminnville, TN 37110', '2500');
insert into employee(fname, lname, phone, addr, pay) values('Carole', 'Mccarthy', '8477951880', '37 Peachtree St. Clinton Township, MI 48035', '3800');
insert into employee(fname, lname, phone, addr, pay) values('Humphreys', 'Spence', '8830597179', '11 S. Smith Drive Sidney, OH 45365', '3900');
insert into employee(fname, lname, phone, addr, pay) values('Riaz', 'Hardy', '8740413343', '8683 South Academy Street Vernon Rockville, CT 06066', '2400');
insert into employee(fname, lname, phone, addr, pay) values('Milo', 'Kyron', '9263524914', '102 Swanson Street Miami Beach, FL 33139', '4900');
insert into employee(fname, lname, phone, addr, pay) values('Couch', 'Reeves', '8506514129', '98 Arch Drive Pelham, AL 35124', '4400');
insert into employee(fname, lname, phone, addr, pay) values('Rogers', 'Le', '8915643928', '4 Sherman Drive Nanuet, NY 10954', '3200');
insert into employee(fname, lname, phone, addr, pay) values('Jarvis', 'Jorge', '9941019534', '572 Sutor Rd. Brentwood, NY 11717', '5000');
insert into employee(fname, lname, phone, addr, pay) values('Dalton', 'Bentley', '8018888588', '85 Sulphur Springs St. Leland, NC 28451', '5000');
insert into employee(fname, lname, phone, addr, pay) values('Jared', 'Benny', '9733036345', '45 Sunnyslope St. Orange, NJ 07050', '3500');
insert into employee(fname, lname, phone, addr, pay) values('Gertrude', 'Nixon', '8565246440', '31 George Street Spring Hill, FL 34608', '2300');
insert into employee(fname, lname, phone, addr, pay) values('Prince', 'Brooke', '8201415491', '791 Ridgewood Lane Racine, WI 53402', '4000');
insert into employee(fname, lname, phone, addr, pay) values('Whelan', 'Gould', '8114799705', '732 Fifth Street Shelton, CT 06484', '3600');
insert into employee(fname, lname, phone, addr, pay) values('Shelby', 'Buxton', '9097204692', '7777 Temple Lane Chandler, AZ 85224', '4000');
insert into employee(fname, lname, phone, addr, pay) values('Mariya', 'Crawford', '9495510609', '40 Wrangler St. Mansfield, MA 02048', '2500');
insert into employee(fname, lname, phone, addr, pay) values('Lola-Rose', 'Marta', '8919808434', '9056 Creek Ave. Greer, SC 29650', '5000');
insert into employee(fname, lname, phone, addr, pay) values('Tymoteusz', 'Eliott', '8551146069', '9547 Durham Street Danvers, MA 01923', '3400');
insert into employee(fname, lname, phone, addr, pay) values('Maksymilian', 'Chang', '8129979890', '719 Rock Creek Street Auburn, NY 13021', '4300');
insert into employee(fname, lname, phone, addr, pay) values('Wilma', 'Kamile', '8772833120', '53 Vermont Court Greensburg, PA 15601', '2600');
insert into employee(fname, lname, phone, addr, pay) values('Aiysha', 'Brian', '9055934603', '7022 North Jones St. Milwaukee, WI 53204', '3700');
insert into employee(fname, lname, phone, addr, pay) values('Alicja', 'Uzair', '8579927064', '7959 Indian Summer Drive Upper Darby, PA 19082', '5000');
insert into employee(fname, lname, phone, addr, pay) values('Seb', 'Vienna', '8248207105', '386 San Pablo St. Jupiter, FL 33458', '4000');
insert into employee(fname, lname, phone, addr, pay) values('Geraint', 'Ramsey', '9225307879', '72 Summer Drive Woodstock, GA 30188', '4600');
insert into employee(fname, lname, phone, addr, pay) values('Kezia', 'Hammond', '9930885497', '961 Addison St. Palm Bay, FL 32907', '2700');
insert into employee(fname, lname, phone, addr, pay) values('Berat', 'Hakim', '8498460385', '420 S. Somerset Rd. Eugene, OR 97402', '2100');
insert into employee(fname, lname, phone, addr, pay) values('Cotton', 'Rollins', '9053664998', '784 Brewery Road South Lyon, MI 48178', '3200');
insert into employee(fname, lname, phone, addr, pay) values('Curtis', 'Carney', '8585956218', '21 S. Wintergreen St. Yakima, WA 98908', '4800');
insert into employee(fname, lname, phone, addr, pay) values('Mahek', 'Sienna', '8052202254', '92 Pearl St. Raeford, NC 28376', '4600');
insert into employee(fname, lname, phone, addr, pay) values('Mallory', 'Easton', '8291214003', '504 S. Rose St. Bronx, NY 10451', '4100');
SELECT 
    *
FROM
    employee;


insert into menu(food_name, price) values('Fish and cheese toastie', 375);
insert into menu(food_name, price) values('Chicken and potato skewers', 200);
insert into menu(food_name, price) values('Potato and chicken stew', 300);
insert into menu(food_name, price) values('Peri Peri Paneer Burger', 250);
insert into menu(food_name, price) values('Chicken Fillet Burger', 225);
insert into menu(food_name, price) values('Carolina BBQ Chicken Burger', 250);
insert into menu(food_name, price) values('Falafel Doner Pitta', 250);
insert into menu(food_name, price) values('Chicken Doner Wrap', 275);
insert into menu(food_name, price) values('Peri Peri Chicken Wrap', 150);
insert into menu(food_name, price) values('Tex Mex Burger', 150);
insert into menu(food_name, price) values('All American Cheese Burger', 275);
insert into menu(food_name, price) values('Rocky Road Chicken Burgr', 275);
insert into menu(food_name, price) values('Popcorn Chicken', 100);
insert into menu(food_name, price) values('Fish & Chips', 200);
insert into menu(food_name, price) values('Fish Steak with Mash Potato', 300);
insert into menu(food_name, price) values('Chicken Steak with Mash Potato', 325);
insert into menu(food_name, price) values('Prawn Alfredo Pasta', 325);
insert into menu(food_name, price) values('Pasta Alfredo', 225);
insert into menu(food_name, price) values('Pasta Arabiata', 250);
insert into menu(food_name, price) values('Pesto Pasta', 200);
insert into menu(food_name, price) values('Garlic Toast', 150);
insert into menu(food_name, price) values('Potato Wedges', 100);
insert into menu(food_name, price) values('Peri Peri Chicken Fingers', 175);
insert into menu(food_name, price) values('Mozzarella & Jalapeño Sticks', 250);
insert into menu(food_name, price) values('Mac & Cheese', 175);
insert into menu(food_name, price) values("Creamy Cheese Pizza", 125);
insert into menu(food_name, price) values("Classic Margherita", 125);
insert into menu(food_name, price) values("Farmer's Fresh Pizza", 100);
insert into menu(food_name, price) values("Chicken Salami & Pepper Pesto Pizza", 225);
insert into menu(food_name, price) values("Espresso Solo Coffee", 350);
insert into menu(food_name, price) values("Cold Coffee", 225);
insert into menu(food_name, price) values("Iced Americano", 175);
insert into menu(food_name, price) values("Raspberry Mojito", 350);
insert into menu(food_name, price) values("Cranberry Mojito", 350);
insert into menu(food_name, price) values("Choco Layered Coffee", 175);
insert into menu(food_name, price) values("Red Velvet Cup Cake", 150);
insert into menu(food_name, price) values("Frozen Mud Pie", 275);
insert into menu(food_name, price) values("Belgian Chocolate", 150);
insert into menu(food_name, price) values("Chicken Nuggets", 150);
SELECT 
    *
FROM
    menu;

insert into orders(cus_id, emp_id, order_date) values(10021, 41, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10039, 24, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10042, 10, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10041, 4, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10038, 39, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10018, 28, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10011, 24, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10017, 47, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10020, 7, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10037, 11, '2020-03-17 03:39:48.993222');
insert into orders(cus_id, emp_id, order_date) values(10022, 29, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10047, 20, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10031, 15, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10040, 29, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10017, 45, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10003, 26, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10033, 47, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10009, 33, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10041, 48, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10023, 22, '2020-03-31 17:01:49.993222');
insert into orders(cus_id, emp_id, order_date) values(10001, 31, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10047, 26, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10050, 6, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10008, 21, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10021, 2, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10028, 40, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10006, 18, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10047, 19, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10041, 21, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10014, 1, '2020-04-04 23:25:37.993222');
insert into orders(cus_id, emp_id, order_date) values(10015, 5, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10003, 27, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10003, 48, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10028, 14, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10046, 50, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10013, 9, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10034, 10, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10007, 27, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10012, 43, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10049, 32, '2020-04-14 16:06:29.993222');
insert into orders(cus_id, emp_id, order_date) values(10037, 33, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10031, 36, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10003, 9, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10034, 8, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10039, 29, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10027, 47, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10006, 1, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10036, 34, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10007, 25, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10042, 26, '2020-04-24 02:48:12.993222');
insert into orders(cus_id, emp_id, order_date) values(10025, 5, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10022, 43, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10029, 39, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10035, 47, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10027, 50, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10006, 40, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10023, 4, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10003, 47, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10003, 34, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10025, 14, '2020-04-28 06:58:57.993222');
insert into orders(cus_id, emp_id, order_date) values(10011, 33, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10023, 46, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10025, 19, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10003, 46, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10026, 39, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10042, 46, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10005, 22, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10036, 28, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10009, 38, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10031, 14, '2020-04-30 07:34:16.993222');
insert into orders(cus_id, emp_id, order_date) values(10012, 10, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10019, 24, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10027, 9, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10022, 38, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10045, 47, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10009, 5, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10007, 1, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10006, 47, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10015, 5, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10022, 35, '2020-05-02 01:56:25.993222');
insert into orders(cus_id, emp_id, order_date) values(10030, 11, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10049, 4, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10030, 5, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10045, 20, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10030, 50, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10031, 15, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10015, 15, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10020, 46, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10027, 13, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10019, 21, '2020-05-12 16:05:08.993222');
insert into orders(cus_id, emp_id, order_date) values(10016, 46, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10023, 36, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10030, 28, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10024, 40, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10050, 22, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10007, 12, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10016, 40, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10019, 19, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10009, 41, '2020-05-28 00:38:39.993222');
insert into orders(cus_id, emp_id, order_date) values(10012, 30, '2020-05-28 00:38:39.993222');
SELECT 
    *
FROM
    orders;

insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 4, 3, 213);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 8, 3, 231);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 5, 3, 221);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 7, 3, 219);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 8, 3, 237);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 1, 3, 210);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 1, 3, 218);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 2, 4, 208);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 6, 4, 225);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 8, 4, 227);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 8, 4, 203);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 8, 4, 233);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 1, 4, 224);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 5, 4, 221);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 6, 4, 235);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 1, 5, 220);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 4, 5, 215);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 8, 5, 212);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 8, 6, 233);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 4, 6, 209);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 1, 6, 207);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 1, 6, 229);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 8, 6, 237);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 1, 6, 201);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 6, 6, 231);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 8, 6, 234);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 7, 6, 206);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 6, 7, 208);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 4, 7, 224);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 5, 7, 231);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 8, 7, 226);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 6, 7, 225);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 1, 7, 218);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 5, 7, 213);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 3, 8, 238);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 4, 8, 207);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 7, 8, 212);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 4, 8, 201);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 3, 8, 233);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 1, 9, 216);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 1, 9, 202);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 8, 9, 215);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 8, 9, 223);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 1, 9, 226);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 2, 9, 213);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 5, 9, 224);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 3, 10, 208);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 1, 10, 229);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 5, 10, 236);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 1, 10, 228);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 5, 10, 206);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 6, 10, 215);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 5, 10, 213);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 3, 10, 226);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 5, 10, 225);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 3, 10, 238);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 1, 11, 228);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 8, 11, 224);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 6, 11, 238);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 7, 11, 216);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 2, 11, 204);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 2, 11, 229);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 2, 12, 209);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 7, 12, 206);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 8, 13, 236);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 1, 13, 213);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 3, 13, 205);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 3, 13, 207);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 6, 13, 231);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 5, 13, 225);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 5, 13, 208);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 1, 13, 201);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 4, 13, 226);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 7, 14, 209);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 7, 14, 213);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 3, 14, 237);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 4, 14, 228);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 8, 14, 226);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 2, 14, 211);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 5, 14, 204);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 7, 14, 238);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 1, 14, 233);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 8, 14, 223);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 8, 15, 211);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 2, 15, 218);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 4, 15, 228);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 4, 15, 221);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 4, 15, 231);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 7, 15, 223);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 3, 15, 209);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 6, 15, 235);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 1, 15, 213);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 5, 16, 230);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 6, 16, 218);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 5, 16, 231);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 5, 16, 221);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 6, 16, 206);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 8, 16, 216);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 8, 16, 232);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 1, 16, 220);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 1, 17, 211);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 6, 17, 203);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 7, 17, 210);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 3, 17, 218);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 6, 17, 228);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 1, 17, 202);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 6, 17, 220);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 5, 17, 237);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 6, 17, 232);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 3, 18, 224);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 3, 18, 221);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 3, 18, 210);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 3, 18, 218);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 8, 19, 211);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 8, 19, 214);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 8, 20, 229);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 6, 20, 227);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 3, 20, 205);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 2, 20, 212);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 4, 20, 226);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 1, 20, 215);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 8, 21, 224);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 2, 21, 212);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 4, 21, 207);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 7, 21, 205);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 6, 21, 228);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 4, 21, 233);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 4, 22, 236);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 8, 22, 204);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 5, 22, 229);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 4, 22, 230);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 4, 22, 235);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 4, 22, 210);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 8, 22, 203);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 2, 22, 218);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 5, 22, 231);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 7, 22, 206);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 6, 23, 226);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 4, 23, 219);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 8, 24, 234);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 2, 24, 229);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 2, 24, 233);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 7, 24, 236);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 1, 24, 204);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 4, 24, 238);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 4, 24, 225);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 1, 24, 237);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 4, 24, 224);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 7, 25, 209);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 4, 25, 233);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 2, 25, 238);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 3, 25, 224);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 4, 25, 237);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 6, 25, 203);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 5, 25, 231);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 5, 26, 213);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 4, 26, 220);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 7, 26, 206);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 7, 26, 226);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 4, 26, 230);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 6, 27, 226);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 7, 27, 222);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 1, 27, 210);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 1, 28, 210);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 5, 28, 217);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 4, 28, 220);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 8, 28, 232);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 8, 28, 228);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 7, 28, 224);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 7, 29, 229);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 4, 29, 231);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 7, 29, 212);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 7, 29, 209);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 1, 29, 230);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 6, 29, 236);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 2, 29, 224);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 2, 29, 217);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 1, 29, 202);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 6, 30, 203);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 5, 30, 204);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 6, 31, 204);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 5, 31, 231);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 1, 32, 225);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 3, 32, 226);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 1, 32, 229);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 5, 32, 221);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 3, 32, 219);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 3, 32, 227);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 6, 32, 214);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 7, 33, 205);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 4, 33, 225);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 8, 33, 210);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 7, 33, 208);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 7, 33, 202);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 6, 33, 228);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 8, 33, 234);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 8, 33, 207);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 3, 34, 215);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 4, 34, 203);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 3, 34, 224);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 7, 34, 206);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 4, 34, 227);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 6, 34, 201);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 4, 35, 210);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 1, 35, 224);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 3, 36, 219);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 7, 36, 227);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 6, 36, 208);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 2, 36, 221);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 4, 36, 216);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 2, 37, 215);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 3, 37, 226);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 2, 38, 236);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 6, 38, 232);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 6, 38, 213);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 3, 39, 217);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 1, 39, 221);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 2, 39, 236);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 8, 39, 234);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 7, 39, 203);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 4, 39, 208);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 8, 40, 237);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 1, 40, 202);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 3, 41, 221);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 3, 41, 208);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 2, 41, 206);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 8, 41, 204);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 8, 42, 202);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 1, 42, 203);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 3, 42, 220);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 3, 42, 228);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 1, 42, 236);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 7, 42, 221);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 5, 42, 226);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 3, 42, 207);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 3, 43, 234);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 7, 43, 203);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 3, 43, 231);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 2, 43, 235);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 1, 43, 209);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 2, 43, 224);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 3, 43, 222);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 3, 43, 216);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 8, 44, 225);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 6, 44, 212);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 8, 44, 219);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 7, 44, 228);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 4, 44, 235);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 1, 45, 202);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 8, 45, 223);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 5, 45, 235);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 7, 45, 231);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 2, 46, 229);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 3, 46, 238);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 2, 46, 209);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 8, 46, 230);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 1, 46, 210);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 5, 46, 219);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 3, 46, 220);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 6, 46, 218);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 6, 47, 229);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 2, 47, 204);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 2, 48, 230);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 3, 48, 220);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 2, 48, 213);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 6, 48, 222);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 5, 48, 238);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 6, 48, 214);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 7, 48, 232);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 3, 48, 204);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 5, 48, 212);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 1, 49, 217);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 8, 49, 224);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 5, 49, 203);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 7, 50, 231);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 8, 50, 213);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 2, 50, 229);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 3, 51, 222);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 5, 51, 218);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 5, 51, 211);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 3, 51, 216);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 4, 51, 205);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 4, 52, 230);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 8, 52, 220);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 1, 52, 217);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 8, 52, 225);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 6, 52, 223);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 8, 52, 232);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 7, 52, 237);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 6, 52, 211);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 3, 53, 228);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 1, 53, 207);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 6, 53, 203);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 6, 53, 206);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 8, 53, 236);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 5, 53, 225);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 7, 53, 214);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 7, 53, 238);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 2, 53, 222);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 5, 54, 207);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 4, 54, 221);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 8, 54, 234);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 7, 54, 222);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 2, 54, 223);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 7, 54, 201);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 7, 55, 233);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 3, 55, 232);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 4, 55, 208);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 2, 55, 222);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 7, 55, 206);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 2, 55, 219);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 1, 55, 229);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 1, 55, 236);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 8, 56, 238);
insert into items(item_name, quantity, order_id, food_id) values("Farmer's Fresh Pizza", 1, 56, 228);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 6, 56, 204);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 4, 56, 221);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 8, 56, 205);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 7, 56, 220);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 1, 57, 235);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 6, 57, 223);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 4, 57, 209);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 5, 57, 224);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 8, 57, 206);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 5, 58, 217);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 3, 58, 226);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 2, 58, 238);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 3, 59, 226);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 3, 59, 237);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 1, 59, 217);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 1, 59, 220);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 7, 59, 231);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 1, 60, 219);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 7, 60, 218);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 4, 61, 201);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 1, 61, 221);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 2, 61, 226);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 1, 61, 235);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 5, 61, 207);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 7, 61, 214);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 7, 61, 217);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 7, 61, 229);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 8, 62, 215);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 1, 62, 222);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 5, 62, 203);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 7, 62, 217);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 1, 62, 208);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 1, 62, 214);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 6, 63, 202);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 6, 63, 221);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 8, 63, 225);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 4, 63, 208);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 2, 63, 207);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 3, 63, 236);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 3, 63, 203);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 6, 63, 209);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 5, 63, 235);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 1, 64, 214);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 2, 64, 222);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 6, 65, 219);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 2, 65, 214);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 4, 66, 219);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 2, 66, 217);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 5, 66, 202);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 7, 66, 226);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 3, 66, 216);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 6, 66, 225);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 7, 67, 220);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 3, 67, 232);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 4, 68, 223);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 8, 68, 207);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 4, 68, 225);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 7, 68, 238);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 4, 68, 202);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 8, 68, 224);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 8, 68, 232);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 3, 69, 224);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 2, 69, 211);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 2, 69, 230);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 2, 69, 223);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 6, 69, 229);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 6, 69, 213);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 3, 70, 204);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 4, 70, 230);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 4, 70, 202);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 7, 70, 212);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 1, 70, 211);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 4, 71, 234);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 6, 71, 221);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 8, 71, 223);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 7, 71, 227);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 6, 72, 229);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 4, 72, 219);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 6, 72, 238);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 8, 72, 235);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 3, 72, 220);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 7, 72, 207);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 6, 72, 211);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 1, 72, 201);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 3, 73, 209);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 6, 73, 232);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 8, 73, 237);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 7, 74, 227);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 5, 74, 230);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 8, 74, 226);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 2, 74, 207);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 7, 74, 210);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 6, 75, 206);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 5, 75, 224);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 4, 76, 223);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 3, 76, 235);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 3, 76, 214);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 7, 76, 209);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 4, 76, 212);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 7, 76, 208);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 4, 76, 217);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 5, 77, 225);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 1, 77, 213);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 7, 77, 209);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 5, 77, 201);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 4, 78, 223);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 4, 78, 205);
insert into items(item_name, quantity, order_id, food_id) values("Potato and chicken stew", 8, 78, 203);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 7, 78, 211);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 4, 78, 224);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 7, 78, 229);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 3, 78, 201);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 3, 78, 235);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 1, 78, 230);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 1, 78, 231);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 8, 79, 201);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 8, 79, 223);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 4, 80, 231);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 3, 80, 205);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 1, 80, 210);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 3, 80, 235);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 6, 80, 216);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 4, 80, 229);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 6, 80, 202);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 4, 80, 204);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 8, 80, 225);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 6, 81, 209);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 6, 81, 218);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 5, 81, 233);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 7, 81, 202);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 6, 81, 211);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 4, 81, 232);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 7, 81, 214);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 3, 81, 219);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 7, 82, 205);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 5, 82, 227);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 6, 82, 210);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 1, 83, 211);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 1, 83, 207);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 1, 83, 210);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 3, 84, 208);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 8, 84, 218);
insert into items(item_name, quantity, order_id, food_id) values("Choco Layered Coffee", 8, 84, 235);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 6, 84, 231);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 2, 84, 225);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 4, 84, 214);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 1, 84, 204);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 4, 84, 226);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 3, 85, 226);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 8, 85, 222);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 5, 85, 231);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 7, 85, 236);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 5, 86, 204);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 8, 86, 227);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 1, 86, 231);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 7, 86, 223);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 2, 87, 223);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 1, 87, 213);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 4, 87, 230);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 7, 87, 212);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 4, 87, 226);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 6, 87, 234);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 8, 87, 206);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 8, 88, 238);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 5, 88, 217);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 2, 88, 223);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 1, 89, 217);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 2, 89, 219);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 4, 89, 216);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 7, 89, 212);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 2, 89, 206);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 6, 89, 236);
insert into items(item_name, quantity, order_id, food_id) values("Creamy Cheese Pizza", 3, 90, 226);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 5, 90, 218);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 5, 90, 207);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 4, 90, 217);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 3, 90, 206);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 6, 90, 238);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 8, 90, 225);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 8, 90, 237);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 6, 90, 234);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 3, 91, 219);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 3, 91, 218);
insert into items(item_name, quantity, order_id, food_id) values("Potato Wedges", 5, 91, 222);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 4, 91, 205);
insert into items(item_name, quantity, order_id, food_id) values("Classic Margherita", 8, 92, 227);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 6, 92, 217);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 7, 92, 204);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 8, 92, 212);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Fillet Burger", 6, 92, 205);
insert into items(item_name, quantity, order_id, food_id) values("Belgian Chocolate", 7, 92, 238);
insert into items(item_name, quantity, order_id, food_id) values("Popcorn Chicken", 8, 92, 213);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 4, 92, 224);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 1, 92, 229);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 2, 92, 219);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 8, 93, 204);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 1, 93, 215);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 4, 93, 206);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 8, 93, 233);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 2, 93, 230);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 8, 93, 201);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Doner Wrap", 5, 94, 208);
insert into items(item_name, quantity, order_id, food_id) values("Red Velvet Cup Cake", 7, 94, 236);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 5, 94, 234);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 4, 94, 214);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 2, 94, 237);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 1, 94, 211);
insert into items(item_name, quantity, order_id, food_id) values("All American Cheese Burger", 2, 95, 211);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Wrap", 5, 95, 209);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 4, 95, 230);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 8, 95, 221);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 6, 95, 206);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 1, 95, 214);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Chicken Fingers", 7, 95, 223);
insert into items(item_name, quantity, order_id, food_id) values("Frozen Mud Pie", 1, 96, 237);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 1, 96, 207);
insert into items(item_name, quantity, order_id, food_id) values("Espresso Solo Coffee", 4, 97, 230);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 5, 97, 229);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 8, 97, 225);
insert into items(item_name, quantity, order_id, food_id) values("Fish Steak with Mash Potato", 8, 97, 215);
insert into items(item_name, quantity, order_id, food_id) values("Mozzarella & Jalapeño Sticks", 6, 97, 224);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Arabiata", 3, 97, 219);
insert into items(item_name, quantity, order_id, food_id) values("Prawn Alfredo Pasta", 4, 97, 217);
insert into items(item_name, quantity, order_id, food_id) values("Pasta Alfredo", 2, 97, 218);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 8, 98, 232);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 6, 98, 212);
insert into items(item_name, quantity, order_id, food_id) values("Fish and cheese toastie", 6, 98, 201);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 4, 98, 231);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 5, 98, 229);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 1, 98, 207);
insert into items(item_name, quantity, order_id, food_id) values("Fish & Chips", 4, 99, 214);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 1, 99, 220);
insert into items(item_name, quantity, order_id, food_id) values("Chicken and potato skewers", 6, 99, 202);
insert into items(item_name, quantity, order_id, food_id) values("Rocky Road Chicken Burgr", 6, 99, 212);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 1, 99, 232);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Salami & Pepper Pesto Pizza", 3, 99, 229);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 4, 99, 221);
insert into items(item_name, quantity, order_id, food_id) values("Raspberry Mojito", 8, 99, 233);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 6, 99, 210);
insert into items(item_name, quantity, order_id, food_id) values("Falafel Doner Pitta", 1, 99, 207);
insert into items(item_name, quantity, order_id, food_id) values("Pesto Pasta", 7, 100, 220);
insert into items(item_name, quantity, order_id, food_id) values("Cold Coffee", 2, 100, 231);
insert into items(item_name, quantity, order_id, food_id) values("Iced Americano", 3, 100, 232);
insert into items(item_name, quantity, order_id, food_id) values("Mac & Cheese", 3, 101, 225);
insert into items(item_name, quantity, order_id, food_id) values("Cranberry Mojito", 1, 101, 234);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 3, 101, 210);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 4, 101, 204);
insert into items(item_name, quantity, order_id, food_id) values("Peri Peri Paneer Burger", 4, 102, 204);
insert into items(item_name, quantity, order_id, food_id) values("Garlic Toast", 4, 102, 221);
insert into items(item_name, quantity, order_id, food_id) values("Tex Mex Burger", 6, 102, 210);
insert into items(item_name, quantity, order_id, food_id) values("Carolina BBQ Chicken Burger", 1, 102, 206);
insert into items(item_name, quantity, order_id, food_id) values("Chicken Steak with Mash Potato", 5, 102, 216);
SELECT 
    *
FROM
    items;

SELECT 
    COUNT(*)
FROM
    items,
    employee,
    menu,
    customer;

SELECT 
    COALESCE(SUM(quantity), 0) AS total,
    menu.food_name,
    menu.food_id
FROM
    items
        RIGHT OUTER JOIN
    menu ON menu.food_id = items.food_id
GROUP BY menu.food_id;

SELECT 
    quantity, food_id
FROM
    (SELECT 
        COALESCE(SUM(quantity), 0) AS quantity, order_date, food_id
    FROM
        (SELECT 
        *
    FROM
        (SELECT 
        quantity, DATE(order_date) AS order_date, food_id
    FROM
        items
    LEFT OUTER JOIN orders ON orders.o_id = items.order_id) AS temp
    WHERE
        DATEDIFF(temp.order_date, CURRENT_TIMESTAMP) <= 30) AS temp1
    GROUP BY food_id) AS temp2
ORDER BY food_id;

SELECT 
    quantity, order_Date, price
FROM
    (SELECT 
        *
    FROM
        (SELECT 
        COALESCE(SUM(quantity), 0) AS quantity, order_date, food_id
    FROM
        (SELECT 
        quantity, DATE(order_date) AS order_date, food_id
    FROM
        items
    LEFT OUTER JOIN orders ON orders.o_id = items.order_id) AS temp
    GROUP BY order_date) AS temp1
    WHERE
        DATEDIFF(temp1.order_date, CURRENT_TIMESTAMP) <= 30) AS temp2
        LEFT OUTER JOIN
    menu ON menu.food_id = temp2.food_id
WHERE
    menu.food_id = 202;

(SELECT 
    quantity, order_date, price
FROM
    (SELECT 
        *
    FROM
        (SELECT 
        quantity, order_date, food_id
    FROM
        items
    LEFT OUTER JOIN orders ON orders.o_id = items.order_id) AS temp
    WHERE
        DATEDIFF(temp.order_date, CURRENT_TIMESTAMP) <= 30) AS temp1
        LEFT OUTER JOIN
    menu ON menu.food_id = temp1.food_id
WHERE
    menu.food_id = 206);