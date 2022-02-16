USE classicmodels;

/* Remove an item from the cart */
DROP PROCEDURE IF EXISTS RemoveItemFromCart;

DELIMITER $$
CREATE PROCEDURE RemoveItemFromCart(IN cart_number INT(11), IN product_code VARCHAR(15))
BEGIN
	DELETE FROM `cartdetails` 
		WHERE cartdetails.cartNumber=cart_number AND 
			  cartdetails.productCode=product_code;
END $$
DELIMITER ;

CALL RemoveItemFromCart(10100, 'S18_2248');

SELECT * from cartdetails;