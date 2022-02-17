USE classicmodels;

/* Change the order quantity of an item */
DROP PROCEDURE IF EXISTS ChangeQuantityInCart;

DELIMITER $$
CREATE PROCEDURE ChangeQuantityInCart(IN cart_number INT(11), IN product_code VARCHAR(15), 
										IN new_quantity INT(11))
BEGIN
	UPDATE `cartdetails` SET quantityAdded=new_quantity
		WHERE cartdetails.cartNumber=cart_number AND 
			  cartdetails.productCode=product_code;
END $$
DELIMITER ;

CALL ChangeQuantityInCart(10100, 'S50_1392', 111);

SELECT * from cartdetails;