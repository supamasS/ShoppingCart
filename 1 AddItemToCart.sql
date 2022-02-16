USE classicmodels;

/* Add an item to the cart */
DROP PROCEDURE IF EXISTS AddItemToCart;

DELIMITER $$
CREATE PROCEDURE AddItemToCart(IN cart_number INT(11), IN product_code VARCHAR(15), 
								IN quantity_added INT(11), IN price_each DECIMAL(10,2),
                                IN cart_line_number SMALLINT(6))
BEGIN
	INSERT INTO `cartdetails`(`cartNumber`,`productCode`,`quantityAdded`,`priceEach`,`cartLineNumber`) 
		VALUES (cart_number, product_code, quantity_added, price_each, cart_line_number);
END $$
DELIMITER ;

CALL AddItemToCart(10100, 'S18_1749',30,'136.00',1);
CALL AddItemToCart(10100, 'S18_2248',27,'100.70',2);
CALL AddItemToCart(10100, 'S50_1392',27,'100.70',3);
CALL AddItemToCart(10100, 'S32_3207',24,'60.28',4);

SELECT * from cartdetails;
