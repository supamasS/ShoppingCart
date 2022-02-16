USE classicmodels;

/* Place an order based on items in the cart */
DROP PROCEDURE IF EXISTS PlaceOrderFromCart;

DELIMITER $$
CREATE PROCEDURE PlaceOrderFromCart(IN cart_number INT(11))
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE product_code VARCHAR(15);
    DECLARE quantity_added INT(11);
    DECLARE price_each DECIMAL(10,2);
	DECLARE cart_line_number SMALLINT(6);
        
	DECLARE order_number INT(11);
    DECLARE customer_number INT(11);
    
	DECLARE cur1 CURSOR FOR SELECT productCode, quantityAdded, priceEach, cartLineNumber 
		FROM `cartdetails` 
		WHERE cartdetails.cartNumber=cart_number;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    SET order_number = (SELECT MAX(orders.orderNumber) FROM orders) + 1;
    SET customer_number = (SELECT shoppingcart.customerNumber FROM shoppingcart 
							WHERE shoppingcart.cartNumber=cart_number);

	INSERT INTO `orders`(`orderNumber`,`orderDate`,`requiredDate`,`shippedDate`,`status`,`comments`,`customerNumber`)
		VALUES (order_number,CURRENT_DATE(),DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY),NULL,'In Process',NULL,customer_number);
    
	OPEN cur1;
    
    read_loop: LOOP
		FETCH cur1 INTO product_code, quantity_added, price_each, cart_line_number;
        IF done THEN
			LEAVE read_loop;
		END IF;
        INSERT  INTO `orderdetails`(`orderNumber`,`productCode`,`quantityOrdered`,`priceEach`,`orderLineNumber`) 
			values (order_number, product_code, quantity_added, price_each, cart_line_number);        
    END LOOP;
    
    CLOSE cur1;
    
    DELETE FROM cartdetails WHERE cartNumber=cart_number;
    DELETE FROM shoppingcart WHERE cartNumber=cart_number;
END $$
DELIMITER ;

CALL PlaceOrderFromCart(10100);

SELECT * FROM cartdetails;
SELECT * FROM shoppingcart;

SET @max_order_number = (SELECT MAX(orderNumber) FROM orders);
SELECT * FROM orders WHERE orderNumber=@max_order_number;
SELECT * FROM orderdetails WHERE orderNumber=@max_order_number;
