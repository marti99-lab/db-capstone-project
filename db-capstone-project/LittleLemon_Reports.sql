-- Task 1: Create OrdersView
DROP VIEW IF EXISTS OrdersView;

CREATE VIEW OrdersView AS
SELECT OrderID, Quantity, TotalCost
FROM orders
WHERE Quantity > 2;

-- Query to check OrdersView output
SELECT * FROM OrdersView;

-- Task 2: Retrieve Customer Order Information
SELECT 
    customerdetails.CustomerID,
    CONCAT(customerdetails.FirstName, ' ', customerdetails.LastName) AS FullName,
    orders.OrderID,
    orders.TotalCost,
    menu.ItemName AS MenuItem,
    menu.Category,
    ordermenu.Quantity
FROM 
    customerdetails
JOIN bookings ON customerdetails.CustomerID = bookings.CustomerID
JOIN orders ON bookings.BookingID = orders.BookingID
JOIN ordermenu ON orders.OrderID = ordermenu.OrderID
JOIN menu ON ordermenu.MenuItemID = menu.MenuItemID
WHERE 
    orders.TotalCost > 150
ORDER BY 
    orders.TotalCost ASC;

-- Task 3: Find Menu Items with More Than 2 Orders
SELECT ItemName
FROM menu
WHERE MenuItemID = ANY (
    SELECT MenuItemID
    FROM ordermenu
    WHERE Quantity > 2
);


