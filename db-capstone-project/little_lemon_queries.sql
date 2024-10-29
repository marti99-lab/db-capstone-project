-- Task 1: Stored Procedure to Get Maximum Ordered Quantity

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS GetMaxQuantity;

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS MaxOrderedQuantity
    FROM ordermenu;
END //

DELIMITER ;

-- Call the procedure for testing
CALL GetMaxQuantity();


-- Task 2: Prepared Statement to Get Order Details by CustomerID

-- Prepare the statement, joining orders -> bookings -> customerdetails
PREPARE GetOrderDetail FROM 
"SELECT o.OrderID, o.Quantity, o.TotalCost 
 FROM orders o
 JOIN bookings b ON o.BookingID = b.BookingID
 JOIN customerdetails c ON b.CustomerID = c.CustomerID
 WHERE c.CustomerID = ?";

-- Set the customer ID for testing
SET @id = 1;

-- Execute the prepared statement
EXECUTE GetOrderDetail USING @id;

-- Deallocate the prepared statement after use (optional)
DEALLOCATE PREPARE GetOrderDetail;


-- Task 3: Stored Procedure to Cancel an Order by OrderID

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS CancelOrder;

DELIMITER //

CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM orders
    WHERE OrderID = order_id;
END //

DELIMITER ;

-- Call the procedure to cancel an order for testing
CALL CancelOrder(1);





